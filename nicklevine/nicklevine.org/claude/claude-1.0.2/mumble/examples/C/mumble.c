/*
 * $Id: //info.ravenbrook.com/user/ndl/lisp/claude/claude-1.0.2/mumble/examples/C/mumble.c#1 $
 *
 *                              MUMBLE.C
 *            Nick Levine, Ravenbrook Limited, 2013-07-24
 *
 * 1.  INTRODUCTION
 *
 * The purpose of this document is to implement the functions which
 * invoke Mumble's exports. This code has been checked against the
 * following compilers: Visual Studio 2012 C and C++; Cygwin; MinGW.
 *
 */

#include <stdio.h>
#include <windows.h>

#define mumble_c
#include "mumble.h"

#if !(__CYGWIN32__ || __MINGW32__)
#include <WinBase.h>
#endif


/*
 * 2.  CONFIGURATION
 *
 * Where is the dll? If you move things around you may need to reset
 * this string.
 *
 */

static char library_location[] = "..\\..\\mumble.dll";


/*
 * 3.  INVOCATION
 *
 */

static HMODULE library;

FARPROC function(char* name) {
  FARPROC address;
  if(!library) {
    /* Load the library. */
    library = LoadLibraryA(library_location);
    if (library == NULL) {
      printf("LoadLibrary failed, tried: \"%s\".\n", library_location);
      exit(1);
    }
  }
  address = GetProcAddress(library, name);
  if (address == NULL) {
    printf("GetProcAddress %s failed.\n", name);
    exit(2);
  }
  return address;
}

#define CALL(fun, argtypes, args)                                      ~' /~/\
        static mumble_res_t (__stdcall *f)argtypes = 0;                      \
        if (!f) {f = (mumble_res_t (__stdcall *)argtypes)function(#fun);}    \
        return (f)args

/*
 * 4.  MUMBLE FUNCTIONS
 *
 */

mumble_res_t __stdcall mumble_close(void) {
  CALL(mumble_close, (void), ());
}

mumble_res_t __stdcall mumble_free(mumble_aggregate_t pointer) {
  CALL(mumble_free, (mumble_aggregate_t), (pointer));
}

mumble_res_t __stdcall mumble_init(void) {
  CALL(mumble_init, (void), ());
}

mumble_res_t __stdcall mumble_invoke_return_object(bool *success, mumble_handle_t(*funct)(mumble_handle_t), mumble_handle_t object) {
  CALL(mumble_invoke_return_object, (bool*, mumble_handle_t(*)(mumble_handle_t), mumble_handle_t), (success, funct, object));
}

mumble_res_t __stdcall mumble_last_error(char **string) {
  CALL(mumble_last_error, (char**), (string));
}

mumble_res_t __stdcall mumble_new_object(mumble_handle_t *object) {
  CALL(mumble_new_object, (mumble_handle_t*), (object));
}

mumble_res_t __stdcall mumble_raise_error(char *error_string) {
  CALL(mumble_raise_error, (char*), (error_string));
}

mumble_res_t __stdcall mumble_remove_objects(mumble_array_t *result, mumble_array_t array) {
  CALL(mumble_remove_objects, (mumble_array_t*, mumble_array_t), (result, array));
}

mumble_res_t __stdcall mumble_request_error(mumble_handle_t object, char *error_string) {
  CALL(mumble_request_error, (mumble_handle_t, char*), (object, error_string));
}

mumble_res_t __stdcall mumble_return_array(mumble_array_t *result, mumble_array_t array) {
  CALL(mumble_return_array, (mumble_array_t*, mumble_array_t), (result, array));
}

mumble_res_t __stdcall mumble_return_object(mumble_handle_t *result, mumble_handle_t object) {
  CALL(mumble_return_object, (mumble_handle_t*, mumble_handle_t), (result, object));
}

mumble_res_t __stdcall mumble_set_callbacks(mumble_handle_t object, mumble_array_t callbacks) {
  CALL(mumble_set_callbacks, (mumble_handle_t, mumble_array_t), (object, callbacks));
}


/*
 * A. REFERENCES
 *
 *
 * B. DOCUMENT HISTORY
 *
 * 2013-07-24 NDL Created.
 *
 *
 * C. COPYRIGHT AND LICENSE
 *
 * Copyright (c) 2013, Ravenbrook Limited
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
