// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/go-openapi/strfmt

package strfmt

// HostnamePattern http://json-schema.org/latest/json-schema-validation.html#anchor114
//  A string instance is valid against this attribute if it is a valid
//  representation for an Internet host name, as defined by RFC 1034, section 3.1 [RFC1034].
//  http://tools.ietf.org/html/rfc1034#section-3.5
//  <digit> ::= any one of the ten digits 0 through 9
//  var digit = /[0-9]/;
//  <letter> ::= any one of the 52 alphabetic characters A through Z in upper case and a through z in lower case
//  var letter = /[a-zA-Z]/;
//  <let-dig> ::= <letter> | <digit>
//  var letDig = /[0-9a-zA-Z]/;
//  <let-dig-hyp> ::= <let-dig> | "-"
//  var letDigHyp = /[-0-9a-zA-Z]/;
//  <ldh-str> ::= <let-dig-hyp> | <let-dig-hyp> <ldh-str>
//  var ldhStr = /[-0-9a-zA-Z]+/;
//  <label> ::= <letter> [ [ <ldh-str> ] <let-dig> ]
//  var label = /[a-zA-Z](([-0-9a-zA-Z]+)?[0-9a-zA-Z])?/;
//  <subdomain> ::= <label> | <subdomain> "." <label>
//  var subdomain = /^[a-zA-Z](([-0-9a-zA-Z]+)?[0-9a-zA-Z])?(\.[a-zA-Z](([-0-9a-zA-Z]+)?[0-9a-zA-Z])?)*$/;
//  <domain> ::= <subdomain> | " "
//
// Additional validations:
//   - for FDQNs, top-level domain (e.g. ".com"), is at least to letters long (no special characters here)
//   - hostnames may start with a digit [RFC1123]
//   - special registered names with an underscore ('_') are not allowed in this context
//   - dashes are permitted, but not at the start or the end of a segment
//   - long top-level domain names (e.g. example.london) are permitted
//   - symbol unicode points are permitted (e.g. emoji) (not for top-level domain)
#HostnamePattern: "^([a-zA-Z0-9\\p{S}\\p{L}]((-?[a-zA-Z0-9\\p{S}\\p{L}]{0,62})?)|([a-zA-Z0-9\\p{S}\\p{L}](([a-zA-Z0-9-\\p{S}\\p{L}]{0,61}[a-zA-Z0-9\\p{S}\\p{L}])?)(\\.)){1,}([a-zA-Z\\p{L}]){2,63})$" // `^([a-zA-Z0-9\p{S}\p{L}]((-?[a-zA-Z0-9\p{S}\p{L}]{0,62})?)|([a-zA-Z0-9\p{S}\p{L}](([a-zA-Z0-9-\p{S}\p{L}]{0,61}[a-zA-Z0-9\p{S}\p{L}])?)(\.)){1,}([a-zA-Z\p{L}]){2,63})$`

// UUIDPattern Regex for UUID that allows uppercase
#UUIDPattern: "(?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{12}$" // `(?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{12}$`

// UUID3Pattern Regex for UUID3 that allows uppercase
#UUID3Pattern: "(?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?3[0-9a-f]{3}-?[0-9a-f]{4}-?[0-9a-f]{12}$" // `(?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?3[0-9a-f]{3}-?[0-9a-f]{4}-?[0-9a-f]{12}$`

// UUID4Pattern Regex for UUID4 that allows uppercase
#UUID4Pattern: "(?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?4[0-9a-f]{3}-?[89ab][0-9a-f]{3}-?[0-9a-f]{12}$" // `(?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?4[0-9a-f]{3}-?[89ab][0-9a-f]{3}-?[0-9a-f]{12}$`

// UUID5Pattern Regex for UUID5 that allows uppercase
#UUID5Pattern: "(?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?5[0-9a-f]{3}-?[89ab][0-9a-f]{3}-?[0-9a-f]{12}$" // `(?i)^[0-9a-f]{8}-?[0-9a-f]{4}-?5[0-9a-f]{3}-?[89ab][0-9a-f]{3}-?[0-9a-f]{12}$`

// json null type
_#jsonNull: "null"

// Base64 represents a base64 encoded string, using URLEncoding alphabet
//
// swagger:strfmt byte
#Base64: string

// URI represents the uri string format as specified by the json schema spec
//
// swagger:strfmt uri
#URI: string

// Email represents the email string format as specified by the json schema spec
//
// swagger:strfmt email
#Email: string

// Hostname represents the hostname string format as specified by the json schema spec
//
// swagger:strfmt hostname
#Hostname: string

// IPv4 represents an IP v4 address
//
// swagger:strfmt ipv4
#IPv4: string

// IPv6 represents an IP v6 address
//
// swagger:strfmt ipv6
#IPv6: string

// CIDR represents a Classless Inter-Domain Routing notation
//
// swagger:strfmt cidr
#CIDR: string

// MAC represents a 48 bit MAC address
//
// swagger:strfmt mac
#MAC: string

// UUID represents a uuid string format
//
// swagger:strfmt uuid
#UUID: string

// UUID3 represents a uuid3 string format
//
// swagger:strfmt uuid3
#UUID3: string

// UUID4 represents a uuid4 string format
//
// swagger:strfmt uuid4
#UUID4: string

// UUID5 represents a uuid5 string format
//
// swagger:strfmt uuid5
#UUID5: string

// ISBN represents an isbn string format
//
// swagger:strfmt isbn
#ISBN: string

// ISBN10 represents an isbn 10 string format
//
// swagger:strfmt isbn10
#ISBN10: string

// ISBN13 represents an isbn 13 string format
//
// swagger:strfmt isbn13
#ISBN13: string

// CreditCard represents a credit card string format
//
// swagger:strfmt creditcard
#CreditCard: string

// SSN represents a social security string format
//
// swagger:strfmt ssn
#SSN: string

// HexColor represents a hex color string format
//
// swagger:strfmt hexcolor
#HexColor: string

// RGBColor represents a RGB color string format
//
// swagger:strfmt rgbcolor
#RGBColor: string

// Password represents a password.
// This has no validations and is mainly used as a marker for UI components.
//
// swagger:strfmt password
#Password: string