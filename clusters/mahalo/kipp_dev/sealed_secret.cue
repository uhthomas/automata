package kipp_dev

import "k8s.io/api/core/v1"

sealedSecretList: v1.#List & {
	apiVersion: "v1"
	kind:       "List"
}

sealedSecretList: items: [{
	apiVersion: "bitnami.com/v1alpha1"
	kind:       "SealedSecret"
	spec: {
		encryptedData: {
			"aws-config": "AgCFxpaq+a2nXdwm2XYYLWiH6PLKTzjizK/H7PrEgYc2evKYmjvJF/5eODZaaz3r+BMSo8zCLIkmcK+v/mQxDe9l9FY5HEq2UJeRLXWqZcFCH3wtcKKZL/LZp7TP+PlLqTCAEUS1tWisBVYOnjRVbQ/9QN+u/b1Sc7PiYX0zsn+xHUkZj+z3FlHwPvqTPeP8jF6JgIfURWXm/THx1PvIU0t1Ug1lIH600MiPUPKRV+zxcvNLoJgRNn86ud64EDKpsz/IyhRebb2TfM19pQ//FkY5Z1pILUmKF1PQ4lajd8ho42w73DE73sC1gCS3SBMjW0lasG50iOLUfwq8Vw8dqjP/j5zUrElhJeM03cCzR027AOP86bRRIJMvYOzThBJBiZrSA1b2a6WiIGeBSbvptI0Cefx3CEjYsVPtoW39LfM7CCQSTqTF0IE1beFJrhh5sWaEQhjsllV+ogPk9aAjvptonpdvGqx/e3TAUjrG++u/ScZHxQ0AofPaQqJdZzSBDhMO22TRuBvLj75FOWlPOnWRbbX0kWlYTW140QtH0VWXi3CbhDx/p8wfCLCaRPjykVNYqU5mb6k2R+Sw19VELMAVFHU8NkNYgkikVgmrotUCep/5vHw7p+cNU6+Hk/kylQa+Vaq1ZQBPtsOpd6I6gT+YY2Pt9XLtor/N/1JHZBmo2ghObeVvHASx2F6t1cJMPCHUqsbk0gS61d5wKkWe89PZN4b1XB3ek6ryyPSVLXl5KUN4m/bJ1F1J8vu2DkSRT67cEZE1/fnfuTt6DbI+/owpjOftI6KDFdItxUF+vyjcIsVT5UAq+AbI22oNYVg8F3xw8VSYhRn7FUb7hZnDP4Gz"
			database:     "AgBFxy2p93gBQVf3Ac5yVUPOx1ooFugLaU5A+DXs0pyawrDiu2uQMh1Ui8p6oIKWscY4OwAGY2XzLFezNNyeWZ1rlLwjQ9sy/Sr4Y/GACoKNHyIFe3az1L9MMQHmeNFg6NtCUWuAcOeAl4Zn11N/ELzXRJSRfRYXMfivm/pg5z7A3V7tJNCDKA99c0EDOsbogYD5RmM2aBkG1eQqZwqOeV1WEUc2qHW2AWVv8HujgYyLjvlLhvQJmbbRlz/MD5MuWkBsxUi+QXkdMk2SlO+xpxi21b4vIKV70M7djgCyhA5wjaR6FVh4N2XBoMS9IGEQjLwS++GYLfB2Gcn1QM1SCg/5wOudtyIkx4I66iAY1JfGrcr+jXBizVatT3Fvx/YxYKNbCYkJplozZrZ3KFLr82e/76b1vlSUXuTeaXW1W73QwAphlUYXoq1S9ao2UjezhnhuHe219cF2jtY3NC2ixiXbxagzGAHk6MAAyCpinHhXWRu6hGAEkJHu7Z6uhR62xJDBFPq0PZ3840ZuKGtRYkp+DKXPY9AAIboHAXj/Tl5++8yHLyPX+GU62JqiiDmmIw0s82aL96Zux2K/Xa11Duz++3Ub/1C/sls9oflb01Vjqolco6BS25PF2HRWmPmVue3mPcH83H+0Z3gDkKdpOCn857Mw7pVEBUaFggI1/fnaKKRNAWoeXamvp1z9sDoyGW9PsBp6eiFyp3rxvNodDOsfs6evNR1OML9YixA6fe1bUHWLzQfhv8Z66KH/sFLXsMnQZlY8V/uhLWsldWRR852ooEx4yOltzNW3L+RJx4YDNBFYWA=="
		}
		template: metadata: {
			name:      "kipp-dev"
			namespace: "kipp-dev"
		}
	}
}]
