note
	description: "Objects that give access to C memory"
	author: "Paul G. Crismer"

	library: "XS_C : eXternal Support C"

	date: "$Date$"
	revision: "$Revision$"
	licensing: "See notice at end of class"

class
	XS_C_MEMORY

inherit
	MEMORY
		export {NONE} all
		redefine
			dispose
		end

	XS_C_MEMORY_ROUTINES

feature -- Access

	handle : POINTER

	to_external : POINTER do Result := handle end

feature -- Status report

	is_valid : BOOLEAN
			-- is this valid memory ?
		do
			Result := handle /= default_pointer
		end

feature {NONE} -- Implementation

	dispose
			-- free external resources
		do
			c_memory_free (handle)
		end

	c_memory_pointer_plus (pointer : POINTER; offset : INTEGER) : POINTER
--		external "C"
--		alias "c_memory_pointer_plus"
		external "C inline"
		alias "[
			((EIF_POINTER) (((char *)$pointer) + (long)$offset))
		]"
		end

	c_memory_copy (destination : POINTER; source : POINTER; length : INTEGER)
--		external "C"
--		alias "c_memory_copy"
		external "C inline"
		alias "[
			memcpy ((char *)$destination, (char *)$source, (long) $length);
			]"
		end

	c_memory_allocate (size : INTEGER) : POINTER
--		external "C"
--		alias "c_memory_allocate"
		external "C inline"
		alias "[
		((EIF_POINTER) calloc ((long) $size, 1))
		]"
		end

	c_memory_resize (block : POINTER; size : INTEGER) : POINTER
--		external "C"
--		alias "c_memory_resize"
		external "C inline"
		alias "[
		((EIF_POINTER) realloc ($block, (long) $size))
		]"
		end

 	c_memory_free (pointer : POINTER)
--		external "C"
--		alias "c_memory_free"
		external "C inline"
		alias "[
		{ free ((char *)$pointer);}
		]"
		end

end -- class XS_C_MEMORY
--
-- Copyright: 2003-2012, Paul G. Crismer, <pgcrism@users.sourceforge.net>
-- Released under the Eiffel Forum License <www.eiffel-forum.org>
-- See file <forum.txt>
--
