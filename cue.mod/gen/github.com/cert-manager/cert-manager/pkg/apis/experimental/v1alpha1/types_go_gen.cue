// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cert-manager/cert-manager/pkg/apis/experimental/v1alpha1

package v1alpha1

// CertificateSigningRequestDurationAnnotationKey is the
// annotation key used to request a particular duration
// represented as a Go Duration.
#CertificateSigningRequestDurationAnnotationKey: "experimental.cert-manager.io/request-duration"

// CertificateSigningRequestIsCAAnnotationKey is the annotation key used to
// request whether the certificate should be marked as CA.
#CertificateSigningRequestIsCAAnnotationKey: "experimental.cert-manager.io/request-is-ca"

// CertificateSigningRequestMinimumDuration is the minimum allowed
// duration that can be requested for a CertificateSigningRequest via
// the experimental.cert-manager.io/request-duration annotation. This
// has to be the same as the minimum allowed value for
// spec.expirationSeconds of a CertificateSigningRequest
#CertificateSigningRequestMinimumDuration: int & 600000000000

// CertificateSigningRequestPrivateKeyAnnotationKey is the annotation key
// used to reference a Secret resource containing the private key used to
// sign the request.
// This annotation *may* not be present, and is used by the 'self signing'
// issuer type to self-sign certificates.
#CertificateSigningRequestPrivateKeyAnnotationKey: "experimental.cert-manager.io/private-key-secret-name"

// CertificateSigningRequestVenafiCustomFieldsAnnotationKey is the annotation
// that passes on JSON encoded custom fields to the Venafi issuer.
// This will only work with Venafi TPP v19.3 and higher.
// The value is an array with objects containing the name and value keys for
// example: `[{"name": "custom-field", "value": "custom-value"}]`
#CertificateSigningRequestVenafiCustomFieldsAnnotationKey: "venafi.experimental.cert-manager.io/custom-fields"

// CertificateSigningRequestVenafiPickupIDAnnotationKey is the annotation key
// used to record the Venafi Pickup ID of a certificate signing request that
// has been submitted to the Venafi API for collection later.
#CertificateSigningRequestVenafiPickupIDAnnotationKey: "venafi.experimental.cert-manager.io/pickup-id"
