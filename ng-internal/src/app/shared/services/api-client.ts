
// Import vendor modules.
import { firstValueFrom } from "rxjs";
import { HttpClient } from "@angular/common/http";
import { HttpErrorResponse } from "@angular/common/http";
import { HttpXsrfTokenExtractor } from "@angular/common/http";
import { inject } from "@angular/core";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { take } from "rxjs";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

export interface ApiRequestConfig {
	method?: "get" | "post" | "delete";
	url: string,
	params?: {
		[ key: string ]: string | number | boolean;
	};
	data?: any;
}

export class ApiErrorResponse {

	public type: string;
	public message: string;
	public cause: unknown;

	/**
	* I initialize the error response.
	*/
	constructor( type: string, message: string, cause: unknown ) {

		this.type = type;
		this.message = message;
		this.cause = cause;

	}

}

export var DEFAULT_TYPE = "Unknown";
export var DEFAULT_MESSAGE = "An unexpected error occurred while processing your request.";

@Injectable({
	providedIn: "root"
})
export class ApiClient {

	private httpClient = inject( HttpClient );
	private xsrfTokenExtractor = inject( HttpXsrfTokenExtractor );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I make a DELETE request with the given configuration.
	*/
	public delete<T>( config: ApiRequestConfig ) : Promise<T> {

		return this.makeRequest<T>({
			method: "delete",
			...config
		});

	}


	/**
	* I make a GET request with the given configuration.
	*/
	public get<T>( config: ApiRequestConfig ) : Promise<T> {

		return this.makeRequest<T>({
			method: "get",
			...config
		});

	}


	/**
	* I extract the error message from the given server error (or provide a default).
	*/
	public getErrorMessage( error: unknown ) : string {

		if ( error instanceof ApiErrorResponse ) {

			return error.message;

		}

		return DEFAULT_MESSAGE;

	}


	/**
	* I make an API request with the given configuration.
	*/
	public makeRequest<T>( config: ApiRequestConfig ) : Promise<T> {

		// By default XSRF tokens are only included in mutation requests. However, in an
		// effort to keep things simple on the server, I want all API requests to include
		// the XSRF token. This way, all requests can all be validated in the same way.
		var xsrfToken = ( this.xsrfTokenExtractor.getToken() || "" );

		var observable = this.httpClient.request<T>(
			( config.method || "get" ),
			config.url,
			{
				headers: {
					// Todo: Can we move this hard-coded name into a provider somehow?
					"X-XSRF-TOKEN": xsrfToken
				},
				params: config.params,
				body: config.data
			}
		);

		return this.handleResponse( config, observable );

	}


	/**
	* I make a POST request with the given configuration.
	*/
	public post<T>( config: ApiRequestConfig ) : Promise<T> {

		return this.makeRequest<T>({
			method: "post",
			...config
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I take the given Observable response and convert it to a Promise. As part of this
	* translation, an error handler is attached and will convert the HTTP error into an
	* API client error (instanceof ApiErrorResponse).
	*/
	private async handleResponse<T>(
		config: ApiRequestConfig,
		observable: Observable<T>
		) : Promise<T> {

		try {

			return await firstValueFrom( observable );

		} catch ( httpResponse ) {

			var error = new ApiErrorResponse( DEFAULT_TYPE, DEFAULT_MESSAGE, httpResponse );

			if ( httpResponse instanceof HttpErrorResponse ) {

				try {

					if (
						( typeof httpResponse.error === "object" ) &&
						( typeof httpResponse.error.error === "object" ) &&
						( typeof httpResponse.error.error.type === "string" ) &&
						( typeof httpResponse.error.error.message === "string" )
						) {

						error.type = httpResponse.error.error.type;
						error.message = httpResponse.error.error.message;

					}

				} catch ( extractionError ) {

					// The error was in an unexpected format.

				}

			}

			throw error;

		}

	}

}
