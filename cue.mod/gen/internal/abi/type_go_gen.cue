// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go internal/abi

package abi

// Type is the runtime representation of a Go type.
//
// Be careful about accessing this type at build time, as the version
// of this type in the compiler/linker may not have the same layout
// as the version in the target binary, due to pointer width
// differences and any experiments. Use cmd/compile/internal/rttype
// or the functions in compiletype.go to access this type instead.
// (TODO: this admonition applies to every type in this package.
// Put it in some shared location?)
#Type: {
	Size_:       uint64 @go(,uintptr)
	PtrBytes:    uint64 @go(,uintptr)
	Hash:        uint32
	TFlag:       #TFlag
	Align_:      uint8
	FieldAlign_: uint8
	Kind_:       #Kind

	// GCData stores the GC type data for the garbage collector.
	// If the KindGCProg bit is set in kind, GCData is a GC program.
	// Otherwise it is a ptrmask bitmap. See mbitmap.go for details.
	GCData?:   null | uint8 @go(,*byte)
	Str:       #NameOff
	PtrToThis: #TypeOff
}

// A Kind represents the specific kind of type that a Type represents.
// The zero Kind is not a valid kind.
#Kind: uint8 // #enumKind

#enumKind:
	#Invalid |
	#Bool |
	#Int |
	#Int8 |
	#Int16 |
	#Int32 |
	#Int64 |
	#Uint |
	#Uint8 |
	#Uint16 |
	#Uint32 |
	#Uint64 |
	#Uintptr |
	#Float32 |
	#Float64 |
	#Complex64 |
	#Complex128 |
	#Array |
	#Chan |
	#Func |
	#Interface |
	#Map |
	#Pointer |
	#Slice |
	#String |
	#Struct |
	#UnsafePointer |
	#KindDirectIface |
	#KindGCProg |
	#KindMask

#values_Kind: {
	Invalid:         #Invalid
	Bool:            #Bool
	Int:             #Int
	Int8:            #Int8
	Int16:           #Int16
	Int32:           #Int32
	Int64:           #Int64
	Uint:            #Uint
	Uint8:           #Uint8
	Uint16:          #Uint16
	Uint32:          #Uint32
	Uint64:          #Uint64
	Uintptr:         #Uintptr
	Float32:         #Float32
	Float64:         #Float64
	Complex64:       #Complex64
	Complex128:      #Complex128
	Array:           #Array
	Chan:            #Chan
	Func:            #Func
	Interface:       #Interface
	Map:             #Map
	Pointer:         #Pointer
	Slice:           #Slice
	String:          #String
	Struct:          #Struct
	UnsafePointer:   #UnsafePointer
	KindDirectIface: #KindDirectIface
	KindGCProg:      #KindGCProg
	KindMask:        #KindMask
}

#Invalid:       #Kind & 0
#Bool:          #Kind & 1
#Int:           #Kind & 2
#Int8:          #Kind & 3
#Int16:         #Kind & 4
#Int32:         #Kind & 5
#Int64:         #Kind & 6
#Uint:          #Kind & 7
#Uint8:         #Kind & 8
#Uint16:        #Kind & 9
#Uint32:        #Kind & 10
#Uint64:        #Kind & 11
#Uintptr:       #Kind & 12
#Float32:       #Kind & 13
#Float64:       #Kind & 14
#Complex64:     #Kind & 15
#Complex128:    #Kind & 16
#Array:         #Kind & 17
#Chan:          #Kind & 18
#Func:          #Kind & 19
#Interface:     #Kind & 20
#Map:           #Kind & 21
#Pointer:       #Kind & 22
#Slice:         #Kind & 23
#String:        #Kind & 24
#Struct:        #Kind & 25
#UnsafePointer: #Kind & 26

// TODO (khr, drchase) why aren't these in TFlag?  Investigate, fix if possible.
#KindDirectIface: #Kind & 32
#KindGCProg:      #Kind & 64
#KindMask:        #Kind & 31

// TFlag is used by a Type to signal what extra type information is
// available in the memory directly following the Type value.
#TFlag: uint8 // #enumTFlag

#enumTFlag:
	#TFlagUncommon |
	#TFlagExtraStar |
	#TFlagNamed |
	#TFlagRegularMemory |
	#TFlagUnrolledBitmap

#values_TFlag: {
	TFlagUncommon:       #TFlagUncommon
	TFlagExtraStar:      #TFlagExtraStar
	TFlagNamed:          #TFlagNamed
	TFlagRegularMemory:  #TFlagRegularMemory
	TFlagUnrolledBitmap: #TFlagUnrolledBitmap
}

// TFlagUncommon means that there is a data with a type, UncommonType,
// just beyond the shared-per-type common data.  That is, the data
// for struct types will store their UncommonType at one offset, the
// data for interface types will store their UncommonType at a different
// offset.  UncommonType is always accessed via a pointer that is computed
// using trust-us-we-are-the-implementors pointer arithmetic.
//
// For example, if t.Kind() == Struct and t.tflag&TFlagUncommon != 0,
// then t has UncommonType data and it can be accessed as:
//
//	type structTypeUncommon struct {
//		structType
//		u UncommonType
//	}
//	u := &(*structTypeUncommon)(unsafe.Pointer(t)).u
#TFlagUncommon: #TFlag & 1

// TFlagExtraStar means the name in the str field has an
// extraneous '*' prefix. This is because for most types T in
// a program, the type *T also exists and reusing the str data
// saves binary size.
#TFlagExtraStar: #TFlag & 2

// TFlagNamed means the type has a name.
#TFlagNamed: #TFlag & 4

// TFlagRegularMemory means that equal and hash functions can treat
// this type as a single region of t.size bytes.
#TFlagRegularMemory: #TFlag & 8

// TFlagUnrolledBitmap marks special types that are unrolled-bitmap
// versions of types with GC programs.
// These types need to be deallocated when the underlying object
// is freed.
#TFlagUnrolledBitmap: #TFlag & 16

// NameOff is the offset to a name from moduledata.types.  See resolveNameOff in runtime.
#NameOff: int32

// TypeOff is the offset to a type from moduledata.types.  See resolveTypeOff in runtime.
#TypeOff: int32

// TextOff is an offset from the top of a text section.  See (rtype).textOff in runtime.
#TextOff: int32

// Method on non-interface type
#Method: {
	Name: #NameOff
	Mtyp: #TypeOff
	Ifn:  #TextOff
	Tfn:  #TextOff
}

// UncommonType is present only for defined types or types with methods
// (if T is a defined type, the uncommonTypes for T and *T have methods).
// Using a pointer to this struct reduces the overall size required
// to describe a non-defined type with no methods.
#UncommonType: {
	PkgPath: #NameOff
	Mcount:  uint16
	Xcount:  uint16
	Moff:    uint32
}

// Imethod represents a method on an interface type
#Imethod: {
	Name: #NameOff
	Typ:  #TypeOff
}

// ArrayType represents a fixed array type.
#ArrayType: {
	Type:   #Type
	Elem?:  null | #Type @go(,*Type)
	Slice?: null | #Type @go(,*Type)
	Len:    uint64       @go(,uintptr)
}

#ChanDir: int // #enumChanDir

#enumChanDir:
	#RecvDir |
	#SendDir |
	#BothDir |
	#InvalidDir

#values_ChanDir: {
	RecvDir:    #RecvDir
	SendDir:    #SendDir
	BothDir:    #BothDir
	InvalidDir: #InvalidDir
}

#RecvDir:    #ChanDir & 1
#SendDir:    #ChanDir & 2
#BothDir:    #ChanDir & 3
#InvalidDir: #ChanDir & 0

// ChanType represents a channel type
#ChanType: {
	Type:  #Type
	Elem?: null | #Type @go(,*Type)
	Dir:   #ChanDir
}

_#structTypeUncommon: StructType: #StructType

#InterfaceType: {
	Type:    #Type
	PkgPath: #Name
	Methods: [...#Imethod] @go(,[]Imethod)
}

#MapType: {
	Type:       #Type
	Key?:       null | #Type @go(,*Type)
	Elem?:      null | #Type @go(,*Type)
	Bucket?:    null | #Type @go(,*Type)
	KeySize:    uint8
	ValueSize:  uint8
	BucketSize: uint16
	Flags:      uint32
}

#SliceType: {
	Type:  #Type
	Elem?: null | #Type @go(,*Type)
}

// funcType represents a function type.
//
// A *Type for each in and out parameter is stored in an array that
// directly follows the funcType (and possibly its uncommonType). So
// a function type with one method, one input, and one output is:
//
//	struct {
//		funcType
//		uncommonType
//		[2]*rtype    // [0] is in, [1] is out
//	}
#FuncType: {
	Type:     #Type
	InCount:  uint16
	OutCount: uint16
}

#PtrType: {
	Type:  #Type
	Elem?: null | #Type @go(,*Type)
}

#StructField: {
	Name:   #Name
	Typ?:   null | #Type @go(,*Type)
	Offset: uint64       @go(,uintptr)
}

#StructType: {
	Type:    #Type
	PkgPath: #Name
	Fields: [...#StructField] @go(,[]StructField)
}

#Name: {
	Bytes?: null | uint8 @go(,*byte)
}

#TraceArgsLimit:    10
#TraceArgsMaxDepth: 5

// maxLen is a (conservative) upper bound of the byte stream length. For
// each arg/component, it has no more than 2 bytes of data (size, offset),
// and no more than one {, }, ... at each level (it cannot have both the
// data and ... unless it is the last one, just be conservative). Plus 1
// for _endSeq.
#TraceArgsMaxLen: 171

#TraceArgsEndSeq:         0xff
#TraceArgsStartAgg:       0xfe
#TraceArgsEndAgg:         0xfd
#TraceArgsDotdotdot:      0xfc
#TraceArgsOffsetTooLarge: 0xfb
#TraceArgsSpecial:        0xf0

#MaxPtrmaskBytes: 2048
