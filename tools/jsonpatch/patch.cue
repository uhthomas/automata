package jsonpatch

#Patch: #Add | #Remove | #Replace | #Move | #Copy | #Test

#Add: #Patch & {
	op:    "add"
	path:  string
	value: _
}

#Remove: #Patch & {
	op:   "remove"
	path: string
}

#Replace: #Patch & {
	op:    "replace"
	path:  string
	value: _
}

#Move: #Patch & {
	op:   "move"
	path: string
	from: string
}

#Copy: #Patch & {
	op:   "copy"
	path: string
	from: string
}

#Test: #Patch & {
	op:    "test"
	path:  string
	value: _
}

#PatchList: [...#Patch]
