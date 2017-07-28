/*
 * $Id: //info.ravenbrook.com/user/ndl/lisp/claude/claude-1.0.2/mumble/examples/C/test.c#1 $
 *
 * mumble.c
 *
 * The purpose of this document is to conduct a basic test of the
 * functionality offered by Mumble.
 *
 */

#include <assert.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>

#include "../../include.mumble.h"
#include "mumble.c"

#if __CYGWIN32__ || __MINGW32__
#else
#include "stdafx.h"
#include <malloc.h>
#define sleep(n) Sleep(n ## 000)
#define alloca _alloca
#endif


/* Mumble callback */

static char *condition_advised;

void mumble_advise_condition(mumble_handle_t object, char *error_string) {
  if(condition_advised) {
    printf("Unexpected mumble_advise_condition...\n\n%s\n", error_string);
    fflush(stdout);
  }
  assert(!condition_advised);
  condition_advised = error_string;
}


mumble_handle_t return_mumble_handle(mumble_handle_t thing) {
  return thing;
}

#define mumble_record_size(n) (offsetof(mumble_record_s, values) + (n) * sizeof(mumble_value_t))
#define mumble_array_size(n)  (offsetof(mumble_array_s, values)  + (n) * sizeof(mumble_value_t))

#define ASSERT_OK(form)   {mumble_res_t res = (form); assert(res == MUMBLE_RES_OK);}
#define ASSERT_FAIL(form) {mumble_res_t res = (form); assert(res == MUMBLE_RES_FAIL);}



int main(int argc, char **argv) {
  bool success;
  mumble_aggregate_t freeable, pointer;
  mumble_array_t callbacks, pair, pair_res, removals_res;
  mumble_handle_t obj_0, obj_1, obj_res;
  mumble_record_t callback;

  ASSERT_OK (mumble_init());

  pointer.string = (char*)0xdeadbeef;
  ASSERT_FAIL (mumble_free(pointer));

  ASSERT_OK (mumble_last_error(&(pointer.string)));
  assert(strcmp(pointer.string, "Pointer to 0xdeadbeef is invalid and cannot be freed.\r\n") == 0);
  ASSERT_OK (mumble_free(pointer));

  ASSERT_OK (mumble_last_error(&(pointer.string)));
  assert(pointer.string == 0);

  ASSERT_OK (mumble_new_object(&obj_0));
  ASSERT_OK (mumble_new_object(&obj_1));

  pair = (mumble_array_t)alloca(mumble_array_size(2));
  pair->length = 2;
  pair->values[0].handle = obj_0;
  pair->values[1].handle = obj_1;

  ASSERT_OK (mumble_return_object(&obj_res, obj_0));
  assert(obj_res == obj_0);

  ASSERT_OK (mumble_return_array(&pair_res, pair));
  assert(pair_res->length == 2);
  assert(pair_res->values[0].handle == obj_0);
  assert(pair_res->values[1].handle == obj_1);

  freeable.array = pair_res;
  ASSERT_OK (mumble_free(freeable));

  success = FALSE;
  ASSERT_OK (mumble_invoke_return_object(&success, return_mumble_handle, obj_1));
  assert(success);

  callback = (mumble_record_t)alloca(mumble_record_size(2));
  callback->values[0].aggregate.string = "mumble_advise_condition";
  callback->values[1].uinteger = (int)mumble_advise_condition;

  callbacks = (mumble_array_t)alloca(mumble_array_size(1));
  callbacks->length = 1;
  callbacks->values[0].aggregate.record = callback;
  ASSERT_OK (mumble_set_callbacks((mumble_handle_t)NULL, callbacks));

  condition_advised = FALSE;
  ASSERT_FAIL (mumble_request_error((mumble_handle_t)NULL,"foo"));
  assert(!condition_advised);
  ASSERT_OK (mumble_request_error(obj_0,"foo"));

  /*
   * We'd like to test that condition_advised has been set. But this
   * test is too simple for that; it's all over before the library has
   * had a chance to switch threads and call back to us.
   */
  /*
  if (condition_advised) {
    freeable.string = condition_advised;
    ASSERT_OK (mumble_free(freeable));
  } else {
    printf("Expected mumble_advise_condition didn't happen.\n");
  }
  */

  pair_res = NULL;
  ASSERT_OK (mumble_remove_objects(&pair_res, pair));
  assert(pair_res->length == 2);
  assert(pair_res->values[0].handle == obj_0);
  assert(pair_res->values[1].handle == obj_1);
  ASSERT_FAIL (mumble_return_object(&obj_res, obj_0));

  freeable.array = pair_res;
  ASSERT_OK (mumble_free(freeable));

  ASSERT_OK (mumble_close());

  printf("ok\n"); fflush(stdout);
}

