package grafana

sealed_secret: [{
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	metadata: name: "grafana"
	spec: {
		encryptedData: {
			database_password: "AgCFdUPMg0tAJKa6En89zyDHLK3v0KAE0+PY06rK0+390WoSBgFwb+KuVHOsLytAFnD4rVeUeVPOUDgCuKNok/ykF6lh3IfVm7pkX7U/ueOAO7bxCJqWZ7n/8UAoYBnShccfxOlEokuSGThoFD2MrohSjjzvpB6T0DgkB5/qb6K97KEM+khNjyBml03/VBQ6v1TfGmgpQr8J+s3yKV+QgHEQ8h74LV1HQmLVfog14rgf72dKEPmBQjNgzdO9PHal8FqijjoVMZKh+BmH3at3Iq71hj5eap04DPI7D/uEu8SZtyM04nu4FX05GxyhigwXkIjbYEwIl3mlckzfAaecwb4XB3nWNaajXruUEf035/hvltmsrpFRQ/A2ZCkVmy622xEkaGYH/YuOAzAhIEfIpY/syEM840v+b7U19o55/id0XygkCj/G/UZm34EDF04VGindaVsvk4Pw/p89B4eHyEdXblN+a3MgZoAM18s0YP4sTrbbvYhikJivHWTIzWY4l4b46PQ7c+D9J11zxzv7nleoCu6YFL0wZTW6DbqpM9OY6fx2suYXFIZZLHn+emBUvovbMbmj6BXHjQu6GiyxJVEMuLTnJohUwq3BKH1dTRM6TJcVVX4sUbTduFMgZgJxrBoQiPlhnqhRZ9d8fBFrWSvl8exV8UnWh9357o595ODjc1a+txIhyNu6Ii1AmY5dCgD17R6S7SD9GobraKtHdcPpFBzAsA=="
			database_url:      "AgAnOZmg+GZ12ZDq4kzcMMG7kEPaZX3hUvTXmL/6z1opl1GMV9Ez52KRzWcADsXUwk9bEFRfVpNR9rGg7gyJ1h8JJe1q6aBj5NRtltiIOkTbIkMtWdTkUs6it4hpfCC3NZuFz51RHAXi/odpm4NVdYZRBP11oVNY9MvwpwU5oQ7Tpd2KPH6+Unvyy/DEzXEAIXwaE55BFNhwLOMxkfBWumYc5ZZyhO0mcvdOzYetYmDTSX+zXkLC3JDexFj/pjs09H1m27R97wHX1+WtxWVA7X49LN9St88hnsNPWcHUyIBvHYJ9EwGkCSMS9alB18sK6vhT8KuEETpH/V9S4Im3kZT/usbO50VKN5Rj9EQ5wHY0AN8oJPcxcZ6npHdeuzkAdZ3OpJ1CosbTlz22BqWcVOC4NwOG9JyA6gLEcVxx6L5WXD04ppmvbYZGWKhiSU9VpFsPLIO6dYUgygB5DDtQA1+wXyHsxVCRdSL8MMg/FsaPJ0WwQLWzQeiXuVqFnp/cvwkAECzB6l+Bpd7gcYoBQXuVGXsVwhm2hV3WrMW9FOlHKzv746rWEDT0ClKWvHXtErcZREv8Wtir2aCdm4SJZ9V6gWrZU777cIFm0s54BNYcdx2JuEh/6nGvoT7MzUBcYwj5/AtfsF1F09pqhGwgKvuy7ThFiQzopQ1y9tk3hegYI48rE41q9OLTllzPKazeTMSGY+EKZiN8eiuttmO6uoyoaqq4XY55Y+cVAZBWJN8+HSa28gtmjdKKzN5M6xGxFFg="
		}
		template: {
			metadata: {
				name:      "grafana"
				namespace: "grafana"
				labels: {
					"app.kubernetes.io/name":      "grafana"
					"app.kubernetes.io/instance":  "grafana"
					"app.kubernetes.io/version":   "7.4.3"
					"app.kubernetes.io/component": "grafana"
				}
			}
			type: "Opaque"
		}
	}
}]
