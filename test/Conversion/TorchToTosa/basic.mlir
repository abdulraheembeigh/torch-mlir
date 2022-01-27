// RUN: torch-mlir-opt <%s -convert-torch-to-tosa -split-input-file -verify-diagnostics | FileCheck %s

// CHECK-LABEL:   func @torch.aten.tanh$basic(
// CHECK-SAME:                                %[[ARG:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.tanh"(%[[ARG_BUILTIN]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>
func @torch.aten.tanh$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.tanh %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.sigmoid$basic(
// CHECK-SAME:                                %[[ARG:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.sigmoid"(%[[ARG_BUILTIN]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>
func @torch.aten.sigmoid$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.sigmoid %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.relu$basic(
// CHECK-SAME:                                %[[ARG:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.clamp"(%[[ARG_BUILTIN]]) {max_fp = 3.40282347E+38 : f32, max_int = 2147483647 : i64, min_fp = 0.000000e+00 : f32, min_int = 0 : i64} : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>  
func @torch.aten.relu$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.relu %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}


// -----

// CHECK-LABEL:   func @torch.aten.log$basic(
// CHECK-SAME:                                %[[ARG:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.log"(%[[ARG_BUILTIN]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>
func @torch.aten.log$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.log %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.exp$basic(
// CHECK-SAME:                                %[[ARG:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.exp"(%[[ARG_BUILTIN]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>
func @torch.aten.exp$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.exp %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.neg$basic(
// CHECK-SAME:                                %[[ARG:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.negate"(%[[ARG_BUILTIN]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>
func @torch.aten.neg$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.neg %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.floor$basic(
// CHECK-SAME:                                %[[ARG:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.floor"(%[[ARG_BUILTIN]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>
func @torch.aten.floor$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.floor %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.bitwise_not$basic(
// CHECK-SAME:                                %[[ARG:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.bitwise_not"(%[[ARG_BUILTIN]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>
func @torch.aten.bitwise_not$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.bitwise_not %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.ceil$basic(
// CHECK-SAME:                                %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_1:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_2:.*]] = "tosa.ceil"(%[[VAL_1]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.from_builtin_tensor %[[VAL_2]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_3]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.ceil$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.ceil %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.reciprocal$basic(
// CHECK-SAME:                                      %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_1:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_2:.*]] = "tosa.reciprocal"(%[[VAL_1]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.from_builtin_tensor %[[VAL_2]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_3]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.reciprocal$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.reciprocal %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.add$basic(
// CHECK-SAME:                               %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>,
// CHECK-SAME:                               %[[VAL_1:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_2:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.to_builtin_tensor %[[VAL_1]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_4:.*]] = torch.constant.int 1
// CHECK:           %[[VAL_5:.*]] = "tosa.const"() {value = dense<1.000000e+00> : tensor<f32>} : () -> tensor<f32>
// CHECK:           %[[VAL_6:.*]] = "tosa.mul"(%[[VAL_3]], %[[VAL_5]]) {shift = 0 : i32} : (tensor<?x?xf32>, tensor<f32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_7:.*]] = "tosa.add"(%[[VAL_2]], %[[VAL_6]]) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_8:.*]] = torch_c.from_builtin_tensor %[[VAL_7]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_8]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.add$basic(%arg0: !torch.vtensor<[?, ?],f32>, %arg1: !torch.vtensor<[?, ?],f32>) -> !torch.vtensor<[?, ?],f32> {
  %int1 = torch.constant.int 1
  %0 = torch.aten.add.Tensor %arg0, %arg1, %int1 : !torch.vtensor<[?, ?],f32>, !torch.vtensor<[?, ?],f32>, !torch.int -> !torch.vtensor<[?, ?],f32>
  return %0 : !torch.vtensor<[?, ?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.sub$basic(
// CHECK-SAME:                               %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>,
// CHECK-SAME:                               %[[VAL_1:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_2:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.to_builtin_tensor %[[VAL_1]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_4:.*]] = torch.constant.int 1
// CHECK:           %[[VAL_5:.*]] = "tosa.const"() {value = dense<1.000000e+00> : tensor<f32>} : () -> tensor<f32>
// CHECK:           %[[VAL_6:.*]] = "tosa.mul"(%[[VAL_3]], %[[VAL_5]]) {shift = 0 : i32} : (tensor<?x?xf32>, tensor<f32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_7:.*]] = "tosa.sub"(%[[VAL_2]], %[[VAL_6]]) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_8:.*]] = torch_c.from_builtin_tensor %[[VAL_7]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_8]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.sub$basic(%arg0: !torch.vtensor<[?, ?],f32>, %arg1: !torch.vtensor<[?, ?],f32>) -> !torch.vtensor<[?, ?],f32> {
  %int1 = torch.constant.int 1
  %0 = torch.aten.sub.Tensor %arg0, %arg1, %int1 : !torch.vtensor<[?, ?],f32>, !torch.vtensor<[?, ?],f32>, !torch.int -> !torch.vtensor<[?, ?],f32>
  return %0 : !torch.vtensor<[?, ?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.mul$basic(
// CHECK-SAME:                               %[[ARG0:.*]]: !torch.vtensor<[?,?],f32>,
// CHECK-SAME:                               %[[ARG1:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG0_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[ARG1_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG1]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.mul"(%[[ARG0_BUILTIN]], %[[ARG1_BUILTIN]]) {shift = 0 : i32} : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>
func @torch.aten.mul$basic(%arg0: !torch.vtensor<[?, ?],f32>, %arg1: !torch.vtensor<[?, ?],f32>) -> !torch.vtensor<[?, ?],f32> {
  %0 = torch.aten.mul.Tensor %arg0, %arg1 : !torch.vtensor<[?, ?],f32>, !torch.vtensor<[?, ?],f32> -> !torch.vtensor<[?, ?],f32>
  return %0 : !torch.vtensor<[?, ?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.div$basic(
// CHECK-SAME:                               %[[ARG0:.*]]: !torch.vtensor<[?,?],f32>,
// CHECK-SAME:                               %[[ARG1:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[ARG0_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[ARG1_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG1]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[RCP:.*]] = "tosa.reciprocal"(%[[ARG1_BUILTIN]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.mul"(%[[ARG0_BUILTIN]], %[[RCP]]) {shift = 0 : i32} : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?],f32>
func @torch.aten.div$basic(%arg0: !torch.vtensor<[?, ?],f32>, %arg1: !torch.vtensor<[?, ?],f32>) -> !torch.vtensor<[?, ?],f32> {
  %0 = torch.aten.div.Tensor %arg0, %arg1 : !torch.vtensor<[?, ?],f32>, !torch.vtensor<[?, ?],f32> -> !torch.vtensor<[?, ?],f32>
  return %0 : !torch.vtensor<[?, ?],f32>
}

// -----

// CHECK-LABEL:   func @test_reduce_mean_dim$basic(
// CHECK-SAME:                           %[[ARG0:.*]]: !torch.vtensor<[?,?,?,?],f32>) -> !torch.vtensor<[?,?,?],f32> {
// CHECK:           %[[ARG0_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG0]] : !torch.vtensor<[?,?,?,?],f32> -> tensor<?x?x?x?xf32>
// CHECK:           %[[ARG1:.*]] = torch.constant.int 0
// CHECK:           %[[ARG1_BUILTIN:.*]] = torch.prim.ListConstruct %[[ARG1]] : (!torch.int) -> !torch.list<!torch.int>
// CHECK:           %[[ARG2_BUILTIN:.*]] = torch.constant.bool false
// CHECK:           %[[ARG3_BUILTIN:.*]] = torch.constant.none
// CHECK:           %[[SUM:.*]] = "tosa.reduce_sum"(%[[ARG0_BUILTIN]]) {axis = 0 : i64} : (tensor<?x?x?x?xf32>) -> tensor<1x?x?x?xf32>
// CHECK:           %[[RESHAPE_SUM:.*]] = "tosa.reshape"(%[[SUM]]) {new_shape = [-1, -1, -1]} : (tensor<1x?x?x?xf32>) -> tensor<?x?x?xf32>
// CHECK:           %[[CONST:.*]] = "tosa.const"() {value = dense<-1.000000e+00> : tensor<f32>} : () -> tensor<f32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.mul"(%[[RESHAPE_SUM]], %[[CONST]]) {shift = 0 : i32} : (tensor<?x?x?xf32>, tensor<f32>) -> tensor<?x?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?x?xf32> -> !torch.vtensor<[?,?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?,?],f32>
func @test_reduce_mean_dim$basic(%arg0: !torch.vtensor<[?,?,?,?],f32>) -> !torch.vtensor<[?,?,?],f32> {
  %dim0 = torch.constant.int 0
  %reducedims = torch.prim.ListConstruct %dim0 : (!torch.int) -> !torch.list<!torch.int>
  %keepdims = torch.constant.bool false
  %dtype = torch.constant.none
  %0 = torch.aten.mean.dim %arg0, %reducedims, %keepdims, %dtype : !torch.vtensor<[?,?,?,?],f32>, !torch.list<!torch.int>, !torch.bool, !torch.none -> !torch.vtensor<[?,?,?],f32>
  return %0 : !torch.vtensor<[?,?,?],f32>
}

// -----

// CHECK-LABEL:   func @test_reduce_sum_dims$basic(
// CHECK-SAME:                          %[[ARG0:.*]]: !torch.vtensor<[?,?,?,?],f32>) -> !torch.vtensor<[?,?,?],f32> {
// CHECK:           %[[ARG0_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG0]] : !torch.vtensor<[?,?,?,?],f32> -> tensor<?x?x?x?xf32>
// CHECK:           %[[ARG1_BUILTIN:.*]] = torch.constant.none
// CHECK:           %[[ARG2_BUILTIN:.*]] = torch.constant.bool false
// CHECK:           %[[ARG3:.*]] = torch.constant.int 0
// CHECK:           %[[ARG3_BUILTIN:.*]] = torch.prim.ListConstruct %[[ARG3]] : (!torch.int) -> !torch.list<!torch.int>
// CHECK:           %[[SUM:.*]] = "tosa.reduce_sum"(%[[ARG0_BUILTIN]]) {axis = 0 : i64} : (tensor<?x?x?x?xf32>) -> tensor<1x?x?x?xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.reshape"(%[[SUM]]) {new_shape = [-1, -1, -1]} : (tensor<1x?x?x?xf32>) -> tensor<?x?x?xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?x?xf32> -> !torch.vtensor<[?,?,?],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?,?],f32>
func @test_reduce_sum_dims$basic(%arg0: !torch.vtensor<[?,?,?,?],f32>) -> !torch.vtensor<[?,?,?],f32> {
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int0 = torch.constant.int 0
    %0 = torch.prim.ListConstruct %int0 : (!torch.int) -> !torch.list<!torch.int>
    %1 = torch.aten.sum.dim_IntList %arg0, %0, %false, %none : !torch.vtensor<[?,?,?,?],f32>, !torch.list<!torch.int>, !torch.bool, !torch.none -> !torch.vtensor<[?,?,?],f32>
    return %1 : !torch.vtensor<[?,?,?],f32>
}

// -----

// CHECK-LABEL:   func @test_reduce_sum$basic(
// CHECK-SAME:                                %[[ARG0:.*]]: !torch.vtensor<[?,?,?,?],f32>) -> !torch.vtensor<[1],f32> {
// CHECK:           %[[ARG0_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG0]] : !torch.vtensor<[?,?,?,?],f32> -> tensor<?x?x?x?xf32>
// CHECK:           %[[ARG1_BUILTIN:.*]] = torch.constant.none
// CHECK:           %[[REDUCE1:.*]] = "tosa.reduce_sum"(%[[ARG0_BUILTIN]]) {axis = 0 : i64} : (tensor<?x?x?x?xf32>) -> tensor<1x?x?x?xf32>
// CHECK:           %[[REDUCE2:.*]] = "tosa.reduce_sum"(%[[REDUCE1]]) {axis = 1 : i64} : (tensor<1x?x?x?xf32>) -> tensor<1x1x?x?xf32>
// CHECK:           %[[REDUCE3:.*]] = "tosa.reduce_sum"(%[[REDUCE2]]) {axis = 2 : i64} : (tensor<1x1x?x?xf32>) -> tensor<1x1x1x?xf32>
// CHECK:           %[[REDUCE4:.*]] = "tosa.reduce_sum"(%[[REDUCE3]]) {axis = 3 : i64} : (tensor<1x1x1x?xf32>) -> tensor<1x1x1x1xf32>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.reshape"(%[[REDUCE4]]) {new_shape = [1]} : (tensor<1x1x1x1xf32>) -> tensor<1xf32>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<1xf32> -> !torch.vtensor<[1],f32>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[1],f32>
func @test_reduce_sum$basic(%arg0: !torch.vtensor<[?,?,?,?],f32>) -> !torch.vtensor<[1],f32> {
  %none = torch.constant.none
  %0 = torch.aten.sum %arg0, %none : !torch.vtensor<[?,?,?,?],f32>, !torch.none -> !torch.vtensor<[1],f32>
  return %0 : !torch.vtensor<[1],f32>
}

// -----

// CHECK-LABEL:   func @test_reduce_all$basic(
// CHECK-SAME:                                %[[ARG0:.*]]: !torch.vtensor<[?,?,?,?],i1>) -> !torch.vtensor<[1],i1> {
// CHECK:           %[[ARG0_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG0]] : !torch.vtensor<[?,?,?,?],i1> -> tensor<?x?x?x?xi1>
// CHECK:           %[[REDUCE1:.*]] = "tosa.reduce_all"(%[[ARG0_BUILTIN]]) {axis = 0 : i64} : (tensor<?x?x?x?xi1>) -> tensor<1x?x?x?xi1>
// CHECK:           %[[REDUCE2:.*]] = "tosa.reduce_all"(%[[REDUCE1]]) {axis = 1 : i64} : (tensor<1x?x?x?xi1>) -> tensor<1x1x?x?xi1>
// CHECK:           %[[REDUCE3:.*]] = "tosa.reduce_all"(%[[REDUCE2]]) {axis = 2 : i64} : (tensor<1x1x?x?xi1>) -> tensor<1x1x1x?xi1>
// CHECK:           %[[REDUCE4:.*]] = "tosa.reduce_all"(%[[REDUCE3]]) {axis = 3 : i64} : (tensor<1x1x1x?xi1>) -> tensor<1x1x1x1xi1>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.reshape"(%[[REDUCE4]]) {new_shape = [1]} : (tensor<1x1x1x1xi1>) -> tensor<1xi1>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<1xi1> -> !torch.vtensor<[1],i1>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[1],i1>
func @test_reduce_all$basic(%arg0: !torch.vtensor<[?,?,?,?],i1>) -> !torch.vtensor<[1],i1> {
  %0 = torch.aten.all %arg0 : !torch.vtensor<[?,?,?,?],i1> -> !torch.vtensor<[1],i1>
  return %0 : !torch.vtensor<[1],i1>
}

// -----

// CHECK-LABEL:   func @test_reduce_any_dim$basic(
// CHECK-SAME:                                    %[[ARG0:.*]]: !torch.vtensor<[?,?,?,?],i1>) -> !torch.vtensor<[?,?,?],i1> {
// CHECK:           %[[ARG0_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG0]] : !torch.vtensor<[?,?,?,?],i1> -> tensor<?x?x?x?xi1>
// CHECK:           %[[ARG1:.*]] = torch.constant.int 0
// CHECK:           %[[ARG2:.*]] = torch.constant.bool false
// CHECK:           %[[REDUCE:.*]] = "tosa.reduce_any"(%[[ARG0_BUILTIN]]) {axis = 0 : i64} : (tensor<?x?x?x?xi1>) -> tensor<1x?x?x?xi1>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.reshape"(%[[REDUCE]]) {new_shape = [-1, -1, -1]} : (tensor<1x?x?x?xi1>) -> tensor<?x?x?xi1>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<?x?x?xi1> -> !torch.vtensor<[?,?,?],i1>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[?,?,?],i1>
func @test_reduce_any_dim$basic(%arg0: !torch.vtensor<[?,?,?,?],i1>) -> !torch.vtensor<[?,?,?],i1> {
  %int0 = torch.constant.int 0
  %false = torch.constant.bool false
  %0 = torch.aten.any.dim %arg0, %int0, %false : !torch.vtensor<[?,?,?,?],i1>, !torch.int, !torch.bool -> !torch.vtensor<[?,?,?],i1>
  return %0 : !torch.vtensor<[?,?,?],i1>
}

// -----

// CHECK-LABEL:   func @test_reduce_any$basic(
// CHECK-SAME:                                %[[ARG0:.*]]: !torch.vtensor<[?,?,?,?],i1>) -> !torch.vtensor<[1],i1> {
// CHECK:           %[[ARG0_BUILTIN:.*]] = torch_c.to_builtin_tensor %[[ARG0]] : !torch.vtensor<[?,?,?,?],i1> -> tensor<?x?x?x?xi1>
// CHECK:           %[[REDUCE1:.*]] = "tosa.reduce_any"(%[[ARG0_BUILTIN]]) {axis = 0 : i64} : (tensor<?x?x?x?xi1>) -> tensor<1x?x?x?xi1>
// CHECK:           %[[REDUCE2:.*]] = "tosa.reduce_any"(%[[REDUCE1]]) {axis = 1 : i64} : (tensor<1x?x?x?xi1>) -> tensor<1x1x?x?xi1>
// CHECK:           %[[REDUCE3:.*]] = "tosa.reduce_any"(%[[REDUCE2]]) {axis = 2 : i64} : (tensor<1x1x?x?xi1>) -> tensor<1x1x1x?xi1>
// CHECK:           %[[REDUCE4:.*]] = "tosa.reduce_any"(%[[REDUCE3]]) {axis = 3 : i64} : (tensor<1x1x1x?xi1>) -> tensor<1x1x1x1xi1>
// CHECK:           %[[RESULT_BUILTIN:.*]] = "tosa.reshape"(%[[REDUCE4]]) {new_shape = [1]} : (tensor<1x1x1x1xi1>) -> tensor<1xi1>
// CHECK:           %[[RESULT:.*]] = torch_c.from_builtin_tensor %[[RESULT_BUILTIN]] : tensor<1xi1> -> !torch.vtensor<[1],i1>
// CHECK:           return %[[RESULT]] : !torch.vtensor<[1],i1>
func @test_reduce_any$basic(%arg0: !torch.vtensor<[?,?,?,?],i1>) -> !torch.vtensor<[1],i1> {
  %0 = torch.aten.any %arg0 : !torch.vtensor<[?,?,?,?],i1> -> !torch.vtensor<[1],i1>
  return %0 : !torch.vtensor<[1],i1>
}

// -----

// CHECK-LABEL:   func @torch.aten.rsqrt$basic(
// CHECK-SAME:                                 %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_1:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_2:.*]] = "tosa.rsqrt"(%[[VAL_1]]) : (tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.from_builtin_tensor %[[VAL_2]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_3]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.rsqrt$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.rsqrt %arg0 : !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.maximum$basic(
// CHECK-SAME:                                   %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>,
// CHECK-SAME:                                   %[[VAL_1:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_2:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.to_builtin_tensor %[[VAL_1]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_4:.*]] = "tosa.maximum"(%[[VAL_2]], %[[VAL_3]]) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_5:.*]] = torch_c.from_builtin_tensor %[[VAL_4]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_5]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.maximum$basic(%arg0: !torch.vtensor<[?,?],f32>, %arg1: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.maximum %arg0, %arg1 : !torch.vtensor<[?,?],f32>, !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.minimum$basic(
// CHECK-SAME:                                   %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>,
// CHECK-SAME:                                   %[[VAL_1:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_2:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.to_builtin_tensor %[[VAL_1]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_4:.*]] = "tosa.minimum"(%[[VAL_2]], %[[VAL_3]]) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_5:.*]] = torch_c.from_builtin_tensor %[[VAL_4]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_5]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.minimum$basic(%arg0: !torch.vtensor<[?,?],f32>, %arg1: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %0 = torch.aten.minimum %arg0, %arg1 : !torch.vtensor<[?,?],f32>, !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.pow.Tensor_Scalar$basic(
// CHECK-SAME:                                             %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_1:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_2:.*]] = torch.constant.float 3.123400e+00
// CHECK:           %[[VAL_3:.*]] = "tosa.const"() {value = dense<3.123400e+00> : tensor<f32>} : () -> tensor<f32>
// CHECK:           %[[VAL_4:.*]] = "tosa.pow"(%[[VAL_1]], %[[VAL_3]]) : (tensor<?x?xf32>, tensor<f32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_5:.*]] = torch_c.from_builtin_tensor %[[VAL_4]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_5]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.pow.Tensor_Scalar$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %fp0 = torch.constant.float 3.123400e+00
  %0 = torch.aten.pow.Tensor_Scalar %arg0, %fp0 : !torch.vtensor<[?,?],f32>, !torch.float -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.rsub.Scalar$basic(
// CHECK-SAME:                                       %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_1:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_2:.*]] = torch.constant.float 3.123400e+00
// CHECK:           %[[VAL_3:.*]] = torch.constant.float 6.432100e+00
// CHECK:           %[[VAL_4:.*]] = "tosa.const"() {value = dense<3.123400e+00> : tensor<f32>} : () -> tensor<f32>
// CHECK:           %[[VAL_5:.*]] = "tosa.const"() {value = dense<6.432100e+00> : tensor<f32>} : () -> tensor<f32>
// CHECK:           %[[VAL_6:.*]] = "tosa.mul"(%[[VAL_1]], %[[VAL_5]]) {shift = 0 : i32} : (tensor<?x?xf32>, tensor<f32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_7:.*]] = "tosa.sub"(%[[VAL_4]], %[[VAL_6]]) : (tensor<f32>, tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_8:.*]] = torch_c.from_builtin_tensor %[[VAL_7]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_8]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.rsub.Scalar$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %other = torch.constant.float 3.123400e+00
  %alpha = torch.constant.float 6.432100e+00
  %0 = torch.aten.rsub.Scalar %arg0, %other, %alpha : !torch.vtensor<[?,?],f32>, !torch.float, !torch.float -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.rsub.Scalar$basic(
// CHECK-SAME:                                       %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
// CHECK:           %[[VAL_1:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_2:.*]] = torch.constant.float 3.123400e+00
// CHECK:           %[[VAL_3:.*]] = torch.constant.int 1
// CHECK:           %[[VAL_4:.*]] = "tosa.const"() {value = dense<3.123400e+00> : tensor<f32>} : () -> tensor<f32>
// CHECK:           %[[VAL_5:.*]] = "tosa.const"() {value = dense<1.000000e+00> : tensor<f32>} : () -> tensor<f32>
// CHECK:           %[[VAL_6:.*]] = "tosa.mul"(%[[VAL_1]], %[[VAL_5]]) {shift = 0 : i32} : (tensor<?x?xf32>, tensor<f32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_7:.*]] = "tosa.sub"(%[[VAL_4]], %[[VAL_6]]) : (tensor<f32>, tensor<?x?xf32>) -> tensor<?x?xf32>
// CHECK:           %[[VAL_8:.*]] = torch_c.from_builtin_tensor %[[VAL_7]] : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
// CHECK:           return %[[VAL_8]] : !torch.vtensor<[?,?],f32>
// CHECK:         }
func @torch.aten.rsub.Scalar$basic(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
  %other = torch.constant.float 3.123400e+00
  %alpha = torch.constant.int 1
  %0 = torch.aten.rsub.Scalar %arg0, %other, %alpha : !torch.vtensor<[?,?],f32>, !torch.float, !torch.int -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

// -----

// CHECK-LABEL:   func @torch.aten.gt.Tensor$basic(
// CHECK-SAME:                                     %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>,
// CHECK-SAME:                                     %[[VAL_1:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],i1> {
// CHECK:           %[[VAL_2:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.to_builtin_tensor %[[VAL_1]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_4:.*]] = "tosa.greater"(%[[VAL_2]], %[[VAL_3]]) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xi1>
// CHECK:           %[[VAL_5:.*]] = torch_c.from_builtin_tensor %[[VAL_4]] : tensor<?x?xi1> -> !torch.vtensor<[?,?],i1>
// CHECK:           return %[[VAL_5]] : !torch.vtensor<[?,?],i1>
// CHECK:         }
func @torch.aten.gt.Tensor$basic(%arg0: !torch.vtensor<[?,?],f32>, %arg1: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],i1> {
  %0 = torch.aten.gt.Tensor %arg0, %arg1 : !torch.vtensor<[?,?],f32>, !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],i1>
  return %0 : !torch.vtensor<[?,?],i1>
}

// -----

// CHECK-LABEL:   func @torch.aten.lt.Tensor$basic(
// CHECK-SAME:                                     %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>,
// CHECK-SAME:                                     %[[VAL_1:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],i1> {
// CHECK:           %[[VAL_2:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.to_builtin_tensor %[[VAL_1]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_4:.*]] = "tosa.greater"(%[[VAL_3]], %[[VAL_2]]) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xi1>
// CHECK:           %[[VAL_5:.*]] = torch_c.from_builtin_tensor %[[VAL_4]] : tensor<?x?xi1> -> !torch.vtensor<[?,?],i1>
// CHECK:           return %[[VAL_5]] : !torch.vtensor<[?,?],i1>
// CHECK:         }
func @torch.aten.lt.Tensor$basic(%arg0: !torch.vtensor<[?,?],f32>, %arg1: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],i1> {
  %0 = torch.aten.lt.Tensor %arg0, %arg1 : !torch.vtensor<[?,?],f32>, !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],i1>
  return %0 : !torch.vtensor<[?,?],i1>
}

// -----

// CHECK-LABEL:   func @torch.aten.eq.Tensor$basic(
// CHECK-SAME:                                     %[[VAL_0:.*]]: !torch.vtensor<[?,?],f32>,
// CHECK-SAME:                                     %[[VAL_1:.*]]: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],i1> {
// CHECK:           %[[VAL_2:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_3:.*]] = torch_c.to_builtin_tensor %[[VAL_1]] : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
// CHECK:           %[[VAL_4:.*]] = "tosa.equal"(%[[VAL_2]], %[[VAL_3]]) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xi1>
// CHECK:           %[[VAL_5:.*]] = torch_c.from_builtin_tensor %[[VAL_4]] : tensor<?x?xi1> -> !torch.vtensor<[?,?],i1>
// CHECK:           return %[[VAL_5]] : !torch.vtensor<[?,?],i1>
// CHECK:         }
func @torch.aten.eq.Tensor$basic(%arg0: !torch.vtensor<[?,?],f32>, %arg1: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],i1> {
  %0 = torch.aten.eq.Tensor %arg0, %arg1 : !torch.vtensor<[?,?],f32>, !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],i1>
  return %0 : !torch.vtensor<[?,?],i1>
}

// -----

// CHECK-LABEL:   func @torch.aten.reshape$basic(
// CHECK-SAME:                                   %[[VAL_0:.*]]: !torch.vtensor<[?,?,?,?],f32>) -> !torch.vtensor<[?],f32> {
// CHECK:           %[[VAL_1:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[?,?,?,?],f32> -> tensor<?x?x?x?xf32>
// CHECK:           %[[VAL_2:.*]] = torch.constant.int -1
// CHECK:           %[[VAL_3:.*]] = torch.prim.ListConstruct %[[VAL_2]] : (!torch.int) -> !torch.list<!torch.int>
// CHECK:           %[[VAL_4:.*]] = "tosa.reshape"(%[[VAL_1]]) {new_shape = [-1]} : (tensor<?x?x?x?xf32>) -> tensor<?xf32>
// CHECK:           %[[VAL_5:.*]] = torch_c.from_builtin_tensor %[[VAL_4]] : tensor<?xf32> -> !torch.vtensor<[?],f32>
// CHECK:           return %[[VAL_5]] : !torch.vtensor<[?],f32>
// CHECK:         }
func @torch.aten.reshape$basic(%arg0: !torch.vtensor<[?,?,?,?],f32>) -> !torch.vtensor<[?],f32> {
  %dim0 = torch.constant.int -1
  %shape = torch.prim.ListConstruct %dim0 : (!torch.int) -> !torch.list<!torch.int>
  %0 = torch.aten.reshape %arg0, %shape : !torch.vtensor<[?,?,?,?],f32>, !torch.list<!torch.int> -> !torch.vtensor<[?],f32>
  return %0 : !torch.vtensor<[?],f32>
}

// -----

// CHECK-LABEL:   func @forward(
// CHECK-SAME:                  %[[VAL_0:.*]]: !torch.vtensor<[10,4,3],f32>) -> !torch.vtensor<[10,4,3],f32> {
// CHECK:           %[[VAL_1:.*]] = torch_c.to_builtin_tensor %[[VAL_0]] : !torch.vtensor<[10,4,3],f32> -> tensor<10x4x3xf32>
// CHECK:           %[[VAL_2:.*]] = "tosa.const"() {value = dense<[5.000000e-01, 4.000000e-01, 3.000000e-01, 6.000000e-01]> : tensor<4xf32>} : () -> tensor<4xf32>
// CHECK:           %[[VAL_3:.*]] = "tosa.const"() {value = dense<[3.000000e+00, 2.000000e+00, 4.000000e+00, 5.000000e+00]> : tensor<4xf32>} : () -> tensor<4xf32>
// CHECK:           %[[VAL_4:.*]] = torch.constant.float 1.000000e-01
// CHECK:           %[[VAL_5:.*]] = torch.constant.float 1.000000e-05
// CHECK:           %[[VAL_6:.*]] = torch.constant.bool true
// CHECK:           %[[VAL_7:.*]] = torch.constant.bool false
// CHECK:           %[[VAL_8:.*]] = "tosa.reshape"(%[[VAL_2]]) {new_shape = [4, 1]} : (tensor<4xf32>) -> tensor<4x1xf32>
// CHECK:           %[[VAL_9:.*]] = "tosa.reshape"(%[[VAL_3]]) {new_shape = [4, 1]} : (tensor<4xf32>) -> tensor<4x1xf32>
// CHECK:           %[[VAL_10:.*]] = "tosa.reshape"(%[[VAL_3]]) {new_shape = [4, 1]} : (tensor<4xf32>) -> tensor<4x1xf32>
// CHECK:           %[[VAL_11:.*]] = "tosa.reshape"(%[[VAL_2]]) {new_shape = [4, 1]} : (tensor<4xf32>) -> tensor<4x1xf32>
// CHECK:           %[[VAL_12:.*]] = "tosa.const"() {value = dense<9.99999974E-6> : tensor<f32>} : () -> tensor<f32>
// CHECK:           %[[VAL_13:.*]] = "tosa.sub"(%[[VAL_1]], %[[VAL_8]]) : (tensor<10x4x3xf32>, tensor<4x1xf32>) -> tensor<10x4x3xf32>
// CHECK:           %[[VAL_14:.*]] = "tosa.add"(%[[VAL_9]], %[[VAL_12]]) : (tensor<4x1xf32>, tensor<f32>) -> tensor<4x1xf32>
// CHECK:           %[[VAL_15:.*]] = "tosa.rsqrt"(%[[VAL_14]]) : (tensor<4x1xf32>) -> tensor<4x1xf32>
// CHECK:           %[[VAL_16:.*]] = "tosa.mul"(%[[VAL_13]], %[[VAL_15]]) {shift = 0 : i32} : (tensor<10x4x3xf32>, tensor<4x1xf32>) -> tensor<10x4x3xf32>
// CHECK:           %[[VAL_17:.*]] = "tosa.mul"(%[[VAL_16]], %[[VAL_10]]) {shift = 0 : i32} : (tensor<10x4x3xf32>, tensor<4x1xf32>) -> tensor<10x4x3xf32>
// CHECK:           %[[VAL_18:.*]] = "tosa.add"(%[[VAL_17]], %[[VAL_11]]) : (tensor<10x4x3xf32>, tensor<4x1xf32>) -> tensor<10x4x3xf32>
// CHECK:           %[[VAL_19:.*]] = torch_c.from_builtin_tensor %[[VAL_18]] : tensor<10x4x3xf32> -> !torch.vtensor<[10,4,3],f32>
// CHECK:           return %[[VAL_19]] : !torch.vtensor<[10,4,3],f32>
// CHECK:         }
func @forward(%arg0: !torch.vtensor<[10,4,3],f32> ) -> !torch.vtensor<[10,4,3],f32> {
  %0 = torch.vtensor.literal(dense<[5.000000e-01, 4.000000e-01, 3.000000e-01, 6.000000e-01]> : tensor<4xf32>) : !torch.vtensor<[4],f32>
  %1 = torch.vtensor.literal(dense<[3.000000e+00, 2.000000e+00, 4.000000e+00, 5.000000e+00]> : tensor<4xf32>) : !torch.vtensor<[4],f32>
  %float1.000000e-01 = torch.constant.float 1.000000e-01
  %float1.000000e-05 = torch.constant.float 1.000000e-05
  %true = torch.constant.bool true
  %false = torch.constant.bool false
  %2 = torch.aten.batch_norm %arg0, %1, %0, %0, %1, %false, %float1.000000e-01, %float1.000000e-05, %true : !torch.vtensor<[10,4,3],f32>, !torch.vtensor<[4],f32>, !torch.vtensor<[4],f32>, !torch.vtensor<[4],f32>, !torch.vtensor<[4],f32>, !torch.bool, !torch.float, !torch.float, !torch.bool -> !torch.vtensor<[10,4,3],f32>
  return %2 : !torch.vtensor<[10,4,3],f32>
}
