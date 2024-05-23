component
	output = false
	hint = "I help translate application errors into appropriate response codes and user-facing messages."
	{

	// Define properties for dependency-injection.
	property name="logger" ioc:type="lib.Logger";

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the error RESPONSE for the given error object. This will be the
	* information that is safe to show to the user.
	*/
	public struct function getResponse( required any error ) {

		switch ( error.type ) {
			case "InternalOnly":
				return as403({
					type: error.type,
					message: "Sorry, you've attempted to use a feature that is currently in private beta. I'm hoping to start opening this up to a wider audience soon. But, I still have some kinks and rough edges to figure out."
				});
			break;
			case "ReCaptchaClient.InvalidToken":
			case "ReCaptchaClient.VerificationFailure":
				return as400();
			break;
			// Anything not handled by an explicit case becomes a generic 500 response.
			default:
				// If this is a domain error, it should have been handled by an explicit
				// case. Let's log it so that we can fix the error handling.
				// --
				// NOTE: Using toString() in order to fix an edge-case in which Adobe
				// ColdFusion throws some errors as objects.
				if ( toString( error.type ).listFirst( "." ) == "App" ) {

					logger.info( "Error not handled by case in errorService.", error );

				}

				return as500();
			break;
		}

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I generate a 400 response object for the given error attributes.
	*/
	private struct function as400( struct errorAttributes = {} ) {

		return getGeneric400Response().append( errorAttributes );

	}


	/**
	* I generate a 403 response object for the given error attributes.
	*/
	private struct function as403( struct errorAttributes = {} ) {

		return getGeneric403Response().append( errorAttributes );

	}


	/**
	* I generate a 404 response object for the given error attributes.
	*/
	private struct function as404( struct errorAttributes = {} ) {

		return getGeneric404Response().append( errorAttributes );

	}


	/**
	* I generate a 422 response object for the given error attributes.
	*/
	private struct function as422( struct errorAttributes = {} ) {

		return getGeneric422Response().append( errorAttributes );

	}


	/**
	* I generate a 429 response object for the given error attributes.
	*/
	private struct function as429( struct errorAttributes = {} ) {

		return getGeneric429Response().append( errorAttributes );

	}


	/**
	* I generate a 500 response object for the given error attributes.
	*/
	private struct function as500( struct errorAttributes = {} ) {

		return getGeneric500Response().append( errorAttributes );

	}


	/**
	* I return the generic "400 Bad Request" response.
	*/
	private struct function getGeneric400Response() {

		return {
			statusCode: 400,
			statusText: "Bad Request",
			type: "BadRequest",
			title: "Bad Request",
			message: "Your request cannot be processed in its current state. Please validate the information in your request and try submitting it again."
		};

	}


	/**
	* I return the generic "403 Forbidden" response.
	*/
	private struct function getGeneric403Response() {

		return {
			statusCode: 403,
			statusText: "Forbidden",
			type: "Forbidden",
			title: "Forbidden",
			message: "Your request is not permitted at this time."
		};

	}


	/**
	* I return the generic "404 Not Found" response.
	*/
	private struct function getGeneric404Response() {

		return {
			statusCode: 404,
			statusText: "Not Found",
			type: "NotFound",
			title: "Page Not Found",
			message: "The resource that you requested either doesn't exist or has been moved to a new location."
		};

	}


	/**
	* I return the generic "422 Unprocessable Entity" response.
	*/
	private struct function getGeneric422Response() {

		return {
			statusCode: 422,
			statusText: "Unprocessable Entity",
			type: "UnprocessableEntity",
			title: "Unprocessable Entity",
			message: "Your request cannot be processed in its current state. Please validate the information in your request and try submitting it again."
		};

	}


	/**
	* I return the generic "429 Too Many Requests" response.
	*/
	private struct function getGeneric429Response() {

		return {
			statusCode: 429,
			statusText: "Too Many Requests",
			type: "TooManyRequests",
			title: "Too Many Requests",
			message: "Your request has been rejected due to rate limiting. Please wait a few minutes and then try submitting your request again."
		};

	}


	/**
	* I return the generic "500 Server Error" response.
	*/
	private struct function getGeneric500Response() {

		return {
			statusCode: 500,
			statusText: "Server Error",
			type: "ServerError",
			title: "Something Went Wrong",
			message: "Sorry, something seems to have gone wrong while handling your request. I'll see if I can figure out what happened and fix it."
		};

	}

}
