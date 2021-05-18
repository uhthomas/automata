package rasmus

import "k8s.io/api/core/v1"

sealedSecretList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		apiVersion: "bitnami.com/v1alpha1"
		kind:       "SealedSecret"
	}]
}

sealedSecretList: items: [{
	spec: {
		encryptedData: cookie: "AgCnUGCIzyu6GE0SBBjlS7xpwkOTGJoGJZLWv7ow7xll2Z3yoUNprf62I7LIqkC9jz9BmTouyVntP64NNSV7wHn/n40kcPiF2djiN3iDH5GBs4b8DNByBYbUCZJFl41kAS0zaOGrgSRcJAiLgrjE6I7XkqxkhjBmHrfTWiH8a3BGFPk8Nm3iPLw/VLGufIQsxj2XX/U7htP6OopOAHVkoQFtjoXHoTU2lOf2F9xh/bKmMtEP9f1ML7Istw4I0rrinsLHxDmIQVVpY169ZJhoKqpjYYpu7UBQ28MAs9XrW9gefKyzsrRfGjaZGBSaGEYccaDHYUCOvyvCb3ClVI3pIIxFH/BEFvBD95I9rSdZE9KmotkC3CJxXQFUk0zoVjsdvNp5Fu9vnKQmC8sprW4OIZmzJshP/kBPwqwuIsypWsDPsEwkKkbnzDje3B5EJpLi8hs3HQ8e5atkQ5fkk7kvmcPCsJ3ewl+AInzYRiD+pvl8JRziVTxXwfHHzNO3k7amc+XPWwmRiJvSJ3kr0jRIKYyQZ7wcyp4dF33fddDNjW8uxTxtDjBV+aE1SB45GZ/r78ivobmy+C6t9QIpzLeRvCcsa2n3Dc46RxyQrak3wxb/6U7PH/tlEimQCnRyMTZy3iTc4PvUsCsdeDDGDwKM8EB1jbtxsDempyh1x0duK/0DQx0wd0MWa3VJG8VkK/0o5mYNlsyI3F9aRZNn7yCJCb1Rm8qIZlutHfGyYBSL9J+TAhTc2LEOdZOW51SgTLVJp8McbpUKmO0Z3Je/A4bzd/29RKo85zSaDlOUXjs+HsahsJNKMRHb6UxcQIMoBFh86J/dMOkqixa6eR0mLxofcm/wqSZ0+IY6UFxR2fBt+4Ge196DUIVU1WaLu98i1gk1n+mcKsAEKgHKB06+rKCLGPZvfdv9XLkZs94gWX+IH7KIQKKcQANsY4wSQjpUKRKgiU2mHXEyURk3vBenevs7XSkw/XXfcQEDb30AUs5sPPfKvNvEo3DIsAyPrOWwKnCW1A0fOzyCniZoYzEFClNkyQM="
		template: metadata: {
			name:      "rasmus"
			namespace: "rasmus"
		}
	}
}]
