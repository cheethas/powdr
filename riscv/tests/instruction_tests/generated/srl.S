# 0 "sources/srl.S"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 0 "<command-line>" 2
# 1 "sources/srl.S"
# See LICENSE for license details.

#*****************************************************************************
# srl.S
#-----------------------------------------------------------------------------

# Test srl instruction.


# 1 "sources/riscv_test.h" 1
# 11 "sources/srl.S" 2
# 1 "sources/test_macros.h" 1






#-----------------------------------------------------------------------
# Helper macros
#-----------------------------------------------------------------------
# 20 "sources/test_macros.h"
# We use a macro hack to simpify code generation for various numbers
# of bubble cycles.
# 36 "sources/test_macros.h"
#-----------------------------------------------------------------------
# RV64UI MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests for instructions with immediate operand
#-----------------------------------------------------------------------
# 92 "sources/test_macros.h"
#-----------------------------------------------------------------------
# Tests for vector config instructions
#-----------------------------------------------------------------------
# 120 "sources/test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register operands
#-----------------------------------------------------------------------
# 148 "sources/test_macros.h"
#-----------------------------------------------------------------------
# Tests for an instruction with register-register operands
#-----------------------------------------------------------------------
# 242 "sources/test_macros.h"
#-----------------------------------------------------------------------
# Test memory instructions
#-----------------------------------------------------------------------
# 319 "sources/test_macros.h"
#-----------------------------------------------------------------------
# Test branch instructions
#-----------------------------------------------------------------------
# 404 "sources/test_macros.h"
#-----------------------------------------------------------------------
# Test jump instructions
#-----------------------------------------------------------------------
# 433 "sources/test_macros.h"
#-----------------------------------------------------------------------
# RV64UF MACROS
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Tests floating-point instructions
#-----------------------------------------------------------------------
# 569 "sources/test_macros.h"
#-----------------------------------------------------------------------
# Pass and fail code (assumes test num is in x28)
#-----------------------------------------------------------------------
# 581 "sources/test_macros.h"
#-----------------------------------------------------------------------
# Test data section
#-----------------------------------------------------------------------
# 12 "sources/srl.S" 2


.globl __runtime_start; __runtime_start: la x10,__return_pointer; sw x1,0(x10); li x10,0

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  test_2: li x10, 2; ebreak; li x1, 0xffff8000; li x2, 0; srl x3, x1, x2;; li x29, 0xffff8000; li x28, 2; bne x3, x29, fail;;
  test_3: li x10, 3; ebreak; li x1, 0xffff8000; li x2, 1; srl x3, x1, x2;; li x29, 0x7fffc000; li x28, 3; bne x3, x29, fail;;
  test_4: li x10, 4; ebreak; li x1, 0xffff8000; li x2, 7; srl x3, x1, x2;; li x29, 0x01ffff00; li x28, 4; bne x3, x29, fail;;
  test_5: li x10, 5; ebreak; li x1, 0xffff8000; li x2, 14; srl x3, x1, x2;; li x29, 0x0003fffe; li x28, 5; bne x3, x29, fail;;
  test_6: li x10, 6; ebreak; li x1, 0xffff8001; li x2, 15; srl x3, x1, x2;; li x29, 0x0001ffff; li x28, 6; bne x3, x29, fail;;

  test_7: li x10, 7; ebreak; li x1, 0xffffffff; li x2, 0; srl x3, x1, x2;; li x29, 0xffffffff; li x28, 7; bne x3, x29, fail;;
  test_8: li x10, 8; ebreak; li x1, 0xffffffff; li x2, 1; srl x3, x1, x2;; li x29, 0x7fffffff; li x28, 8; bne x3, x29, fail;;
  test_9: li x10, 9; ebreak; li x1, 0xffffffff; li x2, 7; srl x3, x1, x2;; li x29, 0x01ffffff; li x28, 9; bne x3, x29, fail;;
  test_10: li x10, 10; ebreak; li x1, 0xffffffff; li x2, 14; srl x3, x1, x2;; li x29, 0x0003ffff; li x28, 10; bne x3, x29, fail;;
  test_11: li x10, 11; ebreak; li x1, 0xffffffff; li x2, 31; srl x3, x1, x2;; li x29, 0x00000001; li x28, 11; bne x3, x29, fail;;

  test_12: li x10, 12; ebreak; li x1, 0x21212121; li x2, 0; srl x3, x1, x2;; li x29, 0x21212121; li x28, 12; bne x3, x29, fail;;
  test_13: li x10, 13; ebreak; li x1, 0x21212121; li x2, 1; srl x3, x1, x2;; li x29, 0x10909090; li x28, 13; bne x3, x29, fail;;
  test_14: li x10, 14; ebreak; li x1, 0x21212121; li x2, 7; srl x3, x1, x2;; li x29, 0x00424242; li x28, 14; bne x3, x29, fail;;
  test_15: li x10, 15; ebreak; li x1, 0x21212121; li x2, 14; srl x3, x1, x2;; li x29, 0x00008484; li x28, 15; bne x3, x29, fail;;
  test_16: li x10, 16; ebreak; li x1, 0x21212121; li x2, 31; srl x3, x1, x2;; li x29, 0x00000000; li x28, 16; bne x3, x29, fail;;

  # Verify that shifts only use bottom five bits

  test_17: li x10, 17; ebreak; li x1, 0x21212121; li x2, 0xffffffe0; srl x3, x1, x2;; li x29, 0x21212121; li x28, 17; bne x3, x29, fail;;
  test_18: li x10, 18; ebreak; li x1, 0x21212121; li x2, 0xffffffe1; srl x3, x1, x2;; li x29, 0x10909090; li x28, 18; bne x3, x29, fail;;
  test_19: li x10, 19; ebreak; li x1, 0x21212121; li x2, 0xffffffe7; srl x3, x1, x2;; li x29, 0x00424242; li x28, 19; bne x3, x29, fail;;
  test_20: li x10, 20; ebreak; li x1, 0x21212121; li x2, 0xffffffee; srl x3, x1, x2;; li x29, 0x00008484; li x28, 20; bne x3, x29, fail;;
  test_21: li x10, 21; ebreak; li x1, 0x21212121; li x2, 0xffffffff; srl x3, x1, x2;; li x29, 0x00000000; li x28, 21; bne x3, x29, fail;;

  #-------------------------------------------------------------
  # Source/Destination tests
  #-------------------------------------------------------------

  test_22: li x10, 22; ebreak; li x1, 0xffff8000; li x2, 1; srl x1, x1, x2;; li x29, 0x7fffc000; li x28, 22; bne x1, x29, fail;;
  test_23: li x10, 23; ebreak; li x1, 0xffff8000; li x2, 14; srl x2, x1, x2;; li x29, 0x0003fffe; li x28, 23; bne x2, x29, fail;;
  test_24: li x10, 24; ebreak; li x1, 7; srl x1, x1, x1;; li x29, 0; li x28, 24; bne x1, x29, fail;;

  #-------------------------------------------------------------
  # Bypassing tests
  #-------------------------------------------------------------

  test_25: li x10, 25; ebreak; li x4, 0; test_25_l1: li x1, 0xffff8000; li x2, 1; srl x3, x1, x2; addi x6, x3, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, test_25_l1; li x29, 0x7fffc000; li x28, 25; bne x6, x29, fail;;
  test_26: li x10, 26; ebreak; li x4, 0; test_26_l1: li x1, 0xffff8000; li x2, 14; srl x3, x1, x2; nop; addi x6, x3, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, test_26_l1; li x29, 0x0003fffe; li x28, 26; bne x6, x29, fail;;
  test_27: li x10, 27; ebreak; li x4, 0; test_27_l1: li x1, 0xffff8000; li x2, 15; srl x3, x1, x2; nop; nop; addi x6, x3, 0; addi x4, x4, 1; li x5, 2; bne x4, x5, test_27_l1; li x29, 0x0001ffff; li x28, 27; bne x6, x29, fail;;

  test_28: li x10, 28; ebreak; li x4, 0; test_28_l1: li x1, 0xffff8000; li x2, 1; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_28_l1; li x29, 0x7fffc000; li x28, 28; bne x3, x29, fail;;
  test_29: li x10, 29; ebreak; li x4, 0; test_29_l1: li x1, 0xffff8000; li x2, 7; nop; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_29_l1; li x29, 0x01ffff00; li x28, 29; bne x3, x29, fail;;
  test_30: li x10, 30; ebreak; li x4, 0; test_30_l1: li x1, 0xffff8000; li x2, 15; nop; nop; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_30_l1; li x29, 0x0001ffff; li x28, 30; bne x3, x29, fail;;
  test_31: li x10, 31; ebreak; li x4, 0; test_31_l1: li x1, 0xffff8000; nop; li x2, 1; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_31_l1; li x29, 0x7fffc000; li x28, 31; bne x3, x29, fail;;
  test_32: li x10, 32; ebreak; li x4, 0; test_32_l1: li x1, 0xffff8000; nop; li x2, 7; nop; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_32_l1; li x29, 0x01ffff00; li x28, 32; bne x3, x29, fail;;
  test_33: li x10, 33; ebreak; li x4, 0; test_33_l1: li x1, 0xffff8000; nop; nop; li x2, 15; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_33_l1; li x29, 0x0001ffff; li x28, 33; bne x3, x29, fail;;

  test_34: li x10, 34; ebreak; li x4, 0; test_34_l1: li x2, 1; li x1, 0xffff8000; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_34_l1; li x29, 0x7fffc000; li x28, 34; bne x3, x29, fail;;
  test_35: li x10, 35; ebreak; li x4, 0; test_35_l1: li x2, 7; li x1, 0xffff8000; nop; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_35_l1; li x29, 0x01ffff00; li x28, 35; bne x3, x29, fail;;
  test_36: li x10, 36; ebreak; li x4, 0; test_36_l1: li x2, 15; li x1, 0xffff8000; nop; nop; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_36_l1; li x29, 0x0001ffff; li x28, 36; bne x3, x29, fail;;
  test_37: li x10, 37; ebreak; li x4, 0; test_37_l1: li x2, 1; nop; li x1, 0xffff8000; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_37_l1; li x29, 0x7fffc000; li x28, 37; bne x3, x29, fail;;
  test_38: li x10, 38; ebreak; li x4, 0; test_38_l1: li x2, 7; nop; li x1, 0xffff8000; nop; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_38_l1; li x29, 0x01ffff00; li x28, 38; bne x3, x29, fail;;
  test_39: li x10, 39; ebreak; li x4, 0; test_39_l1: li x2, 15; nop; nop; li x1, 0xffff8000; srl x3, x1, x2; addi x4, x4, 1; li x5, 2; bne x4, x5, test_39_l1; li x29, 0x0001ffff; li x28, 39; bne x3, x29, fail;;

  test_40: li x10, 40; ebreak; li x1, 15; srl x2, x0, x1;; li x29, 0; li x28, 40; bne x2, x29, fail;;
  test_41: li x10, 41; ebreak; li x1, 32; srl x2, x1, x0;; li x29, 32; li x28, 41; bne x2, x29, fail;;
  test_42: li x10, 42; ebreak; srl x1, x0, x0;; li x29, 0; li x28, 42; bne x1, x29, fail;;
  test_43: li x10, 43; ebreak; li x1, 1024; li x2, 2048; srl x0, x1, x2;; li x29, 0; li x28, 43; bne x0, x29, fail;;

  bne x0, x28, pass; fail: unimp;; pass: la x10,__return_pointer; lw x1,0(x10); ret;



  .data
.balign 4; __return_pointer: .word 0;

 


