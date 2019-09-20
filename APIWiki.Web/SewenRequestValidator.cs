using System;
using System.Web;
using System.Web.Util;

namespace Altairis.Sewen.Wiki {
    public class SewenRequestValidator : RequestValidator {

        protected override bool IsValidRequestString(HttpContext context, string value, RequestValidationSource requestValidationSource, string collectionKey, out int validationFailureIndex) {
            if (requestValidationSource == RequestValidationSource.Form && collectionKey.EndsWith("Html", StringComparison.OrdinalIgnoreCase)) {
                // For form fields ending with "Html" skip the validation
                validationFailureIndex = 0;
                return true;
            }
            else {
                // For all others, perform standard validation
                return base.IsValidRequestString(context, value, requestValidationSource, collectionKey, out validationFailureIndex);
            }
        }

    }
}