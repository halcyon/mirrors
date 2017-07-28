/* $Id: //info.ravenbrook.com/user/ndl/lisp/claude/claude-1.0.2/mumble/include/mumble.h#1 $ */

/*
 *                              MUMBLE.H
 *            Nick Levine, Ravenbrook Limited, 2013-04-23
 *
 * This file declares the types, functions and callbacks used by this
 * version of Mumble. These are all described in detail, in the
 * Reference section of the product documentation.
 *
 */

#ifndef mumble_h
#define mumble_h

#ifdef WIN32
#define bool int32_t
#else
#include <stdbool.h>
#endif

#include <stddef.h>
#include <stdint.h>


/*  TYPE DEFINITIONS */

typedef int32_t mumble_long_t;
typedef uint32_t mumble_ulong_t;

typedef mumble_ulong_t mumble_handle_t;

struct mumble_record_s;
struct mumble_array_s;

typedef union mumble_aggregate_t {
  char *string;               /* UTF-8 */
  struct mumble_record_s *record;
  struct mumble_array_s *array;
} mumble_aggregate_t;

typedef union mumble_value_t {
  mumble_ulong_t uinteger;
  mumble_long_t integer;
  mumble_handle_t handle;
  mumble_aggregate_t aggregate;
} mumble_value_t;

typedef struct mumble_record_s *mumble_record_t;
typedef struct mumble_record_s {
  mumble_value_t values[1];    /* maybe different members of mumble_value_t */
} mumble_record_s;

typedef struct mumble_array_s *mumble_array_t;
typedef struct mumble_array_s {
  mumble_ulong_t length;
  mumble_value_t values[1];    /* all the same members of mumble_value_t */
} mumble_array_s;

typedef mumble_long_t mumble_res_t;

enum {
  MUMBLE_RES_OK   =  0,        /* success */
  MUMBLE_RES_FAIL = -1         /* failure */
};


/* FUNCTION DECLARATIONS */

mumble_res_t __stdcall mumble_close(void);

mumble_res_t __stdcall mumble_free(mumble_aggregate_t);        /* pointer */

mumble_res_t __stdcall mumble_init(void);

mumble_res_t __stdcall mumble_invoke_return_object
                 ~' /~/(bool*,                     ~' /~/~' /~//* result */
                 ~' /~/ mumble_handle_t(*)(mumble_handle_t),   /* funct */
                 ~' /~/ mumble_handle_t);                ~' /~//* object */

mumble_res_t __stdcall mumble_last_error(char**);        ~' /~//* error_string */

mumble_res_t __stdcall mumble_new_object(mumble_handle_t*);    /* object */

mumble_res_t __stdcall mumble_raise_error(char*);        ~' /~//* error_string */

mumble_res_t __stdcall mumble_remove_objects(mumble_array_t*,  /* result */
                                 ~' /~/~' /~/mumble_array_t);  /* array */

mumble_res_t __stdcall mumble_request_error(mumble_handle_t,   /* object */
                                ~' /~/~' /~/char*);      ~' /~//* error_string */

mumble_res_t __stdcall mumble_return_array(mumble_array_t*,    /* result */
                               ~' /~/~' /~/mumble_array_t);    /* array */

mumble_res_t __stdcall mumble_return_object(mumble_handle_t*,  /* result */
                                ~' /~/~' /~/mumble_handle_t);  /* object */

mumble_res_t __stdcall mumble_set_callbacks(mumble_handle_t,   /* object */
                                ~' /~/~' /~/mumble_array_t);   /* callbacks */


/* CALLBACK DECLARATIONS */

void mumble_advise_condition(mumble_handle_t,            ~' /~//* object */
                       ~' /~/char*);               ~' /~/~' /~//* error_string */

#endif                        /* mumble_h */


/* MISCELLANEOUS */

/*
 * We check the that each call into Mumble returned a success
 * code. This is by no means as good as it could be (see "Error
 * handling" in the documentation) but it's better than nothing.
 */

#define CHECK(form) {mumble_res_t res = (form);                             \
                     if(res != MUMBLE_RES_OK) {                             \
		       printf("Fail code %d from line %d in %s: %s\n",~' /~/\
			      res, __LINE__, __FILE__, #form);        ~' /~/\
                       fflush(stdout); exit(res);                     ~' /~/\
		       }                                              ~' /~/\
		     }


/* Macros determining sizes of Mumble records and arrays. */
#define MUMBLE_RECORD_SIZE(n) (offsetof(mumble_record_s, values)   + (n) * sizeof(mumble_value_t))
#define MUMBLE_ARRAY_SIZE(n)  (offsetof(mumble_array_s, values)+ ((n)+1) * sizeof(mumble_value_t))


/*
 * A. REFERENCES
 *
 *
 * B. DOCUMENT HISTORY
 *
 * 2013-04-23 NDL Created.
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
