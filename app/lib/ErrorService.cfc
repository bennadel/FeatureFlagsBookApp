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

		// Some errors include metadata about why the error was thrown. These data-points
		// can be used to generate a more insightful message for the user.
		var metadata = getErrorMetadata( error );

		switch ( error.type ) {
			case "App.Model.Config.CreatedAt.Invalid":
				return as422({
					type: error.type,
					message: "Your created at must be provided as a date. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.DeserializationFailure":
				return as400({
					type: error.type,
					message: "Your configuration data couldn't be parsed as JSON."
				});
			break;
			case "App.Model.Config.Email.Conflict":
				return as422({
					type: error.type,
					message: "You cannot change the email address embedded within settings file. The email address must match the email that you used to log into the application."
				});
			break;
			case "App.Model.Config.Email.Invalid":
				return as422({
					type: error.type,
					message: "Your email must be provided as a string. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Email.Empty":
				return as422({
					type: error.type,
					message: "Your email is empty. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Description.Invalid":
				return as422({
					type: error.type,
					message: "Your environment description must be provided as a string. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Description.SuspiciousEncoding":
				return as422({
					type: error.type,
					message: "Your environment description contains characters with an unsupported encoding format. Please make sure that you're only using plain-text characters. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Description.TooLong":
				return as422({
					type: error.type,
					message: "Your environment description is too long. Descriptions can be up to #metadata.maxLength#-characters long. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Invalid":
			case "App.Model.Config.Environment.Missing":
				return as422({
					type: error.type,
					message: "Your environment must be provided as a struct. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Key.Empty":
				return as422({
					type: error.type,
					message: "Your environment key is empty. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Key.Invalid":
				return as422({
					type: error.type,
					message: "Your environment key must be provided as a string (and can only contain alpha-numeric characters, dashes, and underscores). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Key.TooLong":
				return as422({
					type: error.type,
					message: "Your environment key is too long. Keys can be up to #metadata.maxLength#-characters long. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Name.Invalid":
				return as422({
					type: error.type,
					message: "Your environment name must be provided as a string. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Name.SuspiciousEncoding":
				return as422({
					type: error.type,
					message: "Your environment name contains characters with an unsupported encoding format. Please make sure that you're only using plain-text characters. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environment.Name.TooLong":
				return as422({
					type: error.type,
					message: "Your environment name is too long. Names can be up to #metadata.maxLength#-characters long. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Environments.Invalid":
				return as422({
					type: error.type,
					message: "Your environments must be provided as a struct. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.DefaultSelection.Invalid":
			case "App.Model.Config.Feature.DefaultSelection.OutOfBounds":
				return as422({
					type: error.type,
					message: "Your feature default selection must be provided as an integer that references one of the variant indices (1..#metadata.variantCount#). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Description.Invalid":
				return as422({
					type: error.type,
					message: "Your feature description must be provided as a string. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Description.SuspiciousEncoding":
				return as422({
					type: error.type,
					message: "Your feature description contains characters with an unsupported encoding format. Please make sure that you're only using plain-text characters. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Description.TooLong":
				return as422({
					type: error.type,
					message: "Your feature description is too long. Descriptions can be up to #metadata.maxLength#-characters long. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Invalid":
			case "App.Model.Config.Feature.Missing":
				return as422({
					type: error.type,
					message: "Your feature must be provided as a struct. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Key.Empty":
				return as422({
					type: error.type,
					message: "Your feature key is empty. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Key.Invalid":
				return as422({
					type: error.type,
					message: "Your feature key must be provided as a string (and can only contain alpha-numeric characters, dashes, and underscores). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Key.TooLong":
				return as422({
					type: error.type,
					message: "Your feature key is too long. Keys can be up to #metadata.maxLength#-characters long. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.NotFound":
				return as404({
					type: error.type,
					message: "The feature you requested cannot be found."
				});
			break;
			case "App.Model.Config.Feature.Targeting.Entry.Missing":
			case "App.Model.Config.Feature.Targeting.Entry.OutOfBounds":
				return as422({
					type: error.type,
					message: "Your feature targeting entries must all correspond to the list of defined environments. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Targeting.Invalid":
			case "App.Model.Config.Feature.Targeting.Missing":
				return as422({
					type: error.type,
					message: "Your feature targeting must be provided as a struct. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Type.Invalid":
			case "App.Model.Config.Feature.Type.Missing":
				return as422({
					type: error.type,
					message: "Your feature type must be provided as a string. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Type.Unsupported":
				return as422({
					type: error.type,
					message: "Your feature type must be one of (#metadata.typeList#). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Variants.Empty":
				return as422({
					type: error.type,
					message: "Your feature variants must be provided as an array with at least one entry of type (#metadata.featureType#). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Feature.Variants.Invalid":
			case "App.Model.Config.Feature.Variants.Missing":
				return as422({
					type: error.type,
					message: "Your feature variants must be provided as an array. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Features.Invalid":
				return as422({
					type: error.type,
					message: "Your features must be provided as a struct. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Invalid":
			case "App.Model.Config.Missing":
				return as422({
					type: error.type,
					message: "Your config must be provided as a string. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Resolution.Distribution.Entry.Invalid":
				return as422({
					type: error.type,
					message: "Your resolution distribution entry must be provided as an integer. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Resolution.Distribution.Invalid":
			case "App.Model.Config.Resolution.Distribution.Missing":
				return as422({
					type: error.type,
					message: "Your resolution distribution must be provided as an array. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Resolution.Distribution.InvalidTotal":
				return as422({
					type: error.type,
					message: "Your resolution distribution entries must sum to a total of 100. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Resolution.Distribution.Mismatch":
				return as422({
					type: error.type,
					message: "Your resolution distribution array length must match the length of the variants (#metadata.variantCount#). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Resolution.Invalid":
			case "App.Model.Config.Resolution.Missing":
				return as422({
					type: error.type,
					message: "Your resolution must be provided as a struct. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Resolution.Selection.Invalid":
			case "App.Model.Config.Resolution.Selection.Missing":
				return as422({
					type: error.type,
					message: "Your resolution selection must be provided as an integer. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Resolution.Selection.OutOfBounds":
				return as422({
					type: error.type,
					message: "Your resolution selection must point to a variant index (1..#metadata.variantCount#). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Resolution.Type.Invalid":
			case "App.Model.Config.Resolution.Type.Missing":
				return as422({
					type: error.type,
					message: "Your resolution type must be provided as a string. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Rule.Input.Empty":
				return as422({
					type: error.type,
					message: "Your rule input is empty. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Rule.Input.Invalid":
			case "App.Model.Config.Rule.Input.Missing":
				return as422({
					type: error.type,
					message: "Your rule input must be provided as a string. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Rule.Invalid":
			case "App.Model.Config.Rule.Missing":
				return as422({
					type: error.type,
					message: "Your rule must be provided as a struct. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Rule.Operator.Invalid":
			case "App.Model.Config.Rule.Operator.Missing":
				return as422({
					type: error.type,
					message: "Your rule operator must be provided as a string. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Rule.Operator.Unsupported":
				return as422({
					type: error.type,
					message: "Your rule operator must be one of (#metadata.operatorList#). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Rule.Values.Entry.BadPattern":
				return as422({
					type: error.type,
					message: "Your rule values entry cannot be parsed as a Regular Expression. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Rule.Values.Entry.Invalid":
				return as422({
					type: error.type,
					message: "Your rule values entry must be provided as a simple value (such as a string, number, boolean). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Rule.Values.Invalid":
			case "App.Model.Config.Rule.Values.Missing":
				return as422({
					type: error.type,
					message: "Your rules values must be provided as an array. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.SerializationFailure":
				return as400({
					type: error.type,
					message: "Your configuration data couldn't be serialized as JSON."
				});
			break;
			case "App.Model.Config.Targeting.Invalid":
			case "App.Model.Config.Targeting.Missing":
				return as422({
					type: error.type,
					message: "Your targeting must be provided as a struct. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Targeting.NotFound":
				return as404({
					type: error.type,
					message: "The targeting you requested cannot be found."
				});
			break;
			case "App.Model.Config.Targeting.Rules.Invalid":
			case "App.Model.Config.Targeting.Rules.Missing":
				return as422({
					type: error.type,
					message: "Your targeting rules must be provided as an array. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Targeting.RulesEnabled.Invalid":
			case "App.Model.Config.Targeting.RulesEnabled.Missing":
				return as422({
					type: error.type,
					message: "Your targeting rules enabled must be provided as a Boolean. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.UpdatedAt.Invalid":
				return as422({
					type: error.type,
					message: "Your updated at must be provided as a date. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.UpdatedAt.OutOfBounds":
				return as422({
					type: error.type,
					message: "Your updated at date must come at or after your created at date. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Variant.Invalid":
			case "App.Model.Config.Variant.Missing":
				return as422({
					type: error.type,
					message: "Your variant must match the designated feature type (#metadata.featureType#). Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.Config.Version.Conflict":
				return as422({
					type: error.type,
					message: "You cannot change the version embedded within settings file. This property is managed by the application."
				});
			break;
			case "App.Model.Config.Version.Invalid":
				return as422({
					type: error.type,
					message: "Your version must be provided as an integer. Validating property: [#metadata.validationPath#]."
				});
			break;
			case "App.Model.User.Email.Empty":
				return as422({
					type: error.type,
					message: "Your email address is empty. Please provide a valid email address."
				});
			break;
			case "App.Model.User.Email.Example":
				return as422({
					type: error.type,
					message: "Your email address is using an unsupported domain. Please choose another email address."
				});
			break;
			case "App.Model.User.Email.InvalidFormat":
				return as422({
					type: error.type,
					message: "Your email address is in an unexpected format. Please double-check your email address."
				});
			break;
			case "App.Model.User.Email.Plus":
				return as422({
					type: error.type,
					message: "Your email address is using plus (+) mechanics. You don't have to do that - I'm not recording your email nor will I attempt to send you any communications. This site is for illustrative purposes only. Just pick an email address that you can easily remember."
				});
			break;
			case "App.Model.User.Email.SuspiciousEncoding":
				return as422({
					type: error.type,
					message: "Your email address contains characters with an unsupported encoding format. Please make sure that you're only using plain-text characters."
				});
			break;
			case "App.Model.User.Email.TooLong":
				return as422({
					type: error.type,
					message: "Your email address is too long. Please use an email address that is less than 75-characters long."
				});
			break;
			case "App.Routing.InvalidEvent":
			case "App.Routing.Auth.InvalidEvent":
			case "App.Routing.Features.InvalidEvent":
			case "App.Routing.Home.InvalidEvent":
			case "App.Routing.Staging.InvalidEvent":
				return as404({
					type: error.type
				});
			break;
			case "App.Turnstile.InvalidToken":
			case "App.Turnstile.VerificationFailure":
				return as400({
					type: error.type,
					message: "Your form has expired. Please try submitting your request again."
				});
			break;
			case "InternalOnly":
				return as403({
					type: error.type,
					message: "Sorry, you've attempted to use a feature that is currently in private beta. I'm hoping to start opening this up to a wider audience soon. But, I still have some kinks and rough edges to figure out."
				});
			break;
			// Anything not handled by an explicit case becomes a generic 500 response.
			default:
				// If this is a domain error, it should have been handled by an explicit
				// switch-case above. Let's log it so that we can fix the error handling
				// in a future update.
				// --
				// NOTE: Using toString() in order to fix an edge-case in which Adobe
				// ColdFusion throws some errors as objects.
				if ( toString( error.type ).listFirst( "." ) == "App" ) {

					logger.info( "Error not handled by case in ErrorService.", error );

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
	* Some throw() commands OVERLOAD the "extendedInfo" property of an event to transmit
	* meta-data about why the error occurred up to the centralized error handler (ie, this
	* component). This methods attempts to deserialize the extendedInfo payload and return
	* the given structure. If the meta-data cannot be deserialized an empty struct is
	* returned.
	*/
	private struct function getErrorMetadata( required any error ) {

		try {

			if ( isJson( error.extendedInfo ) ) {

				return deserializeJson( error.extendedInfo );

			}

		} catch ( any deserializationError ) {

			// ... swallow any deserialization errors for now.

		}

		return {};

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
