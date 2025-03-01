#-------------------------------------------------------------------------------
# Setup PyTorch/LTC
#-------------------------------------------------------------------------------


list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/python/torch_mlir/cmake/modules")
include(TorchMLIRPyTorch)

TorchMLIRProbeForPyTorchInstall()
if(TORCH_MLIR_USE_INSTALLED_PYTORCH)
  TorchMLIRConfigurePyTorch()
else()
  set(Torch_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../../../libtorch/share/cmake/Torch")
endif()

find_package(Torch 1.11 REQUIRED)

set(TORCHGEN_DIR ${Torch_ROOT}/../../../torchgen)

include_directories(BEFORE
  ${TORCH_INCLUDE_DIRS}
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_BINARY_DIR}
  ${Python3_INCLUDE_DIRS}
  ${PROJECT_SOURCE_DIR}/python
)
link_directories("${TORCH_INSTALL_PREFIX}/lib")

set(LTC_GENERATED
  generated/LazyNativeFunctions.cpp
  generated/RegisterLazy.cpp
  generated/shape_inference.cpp
)
set(LTC_BACKEND_DEPENDS
  mlir_lowering_context.cpp
  mlir_native_functions.cpp
  mlir_node_lowering.cpp
  shape_inference.cpp
)

# Generate Lazy IR Nodes

add_custom_command(
  COMMAND ${Python3_EXECUTABLE} ${PROJECT_SOURCE_DIR}/build_tools/autogen_ltc_backend.py -b ${TORCH_MLIR_BINARY_DIR}
  OUTPUT
  ${TORCH_MLIR_BINARY_DIR}/generated_backend.hash
  ${LTC_GENERATED}
  DEPENDS
  ${PROJECT_SOURCE_DIR}/build_tools/autogen_ltc_backend.py
  ${PROJECT_SOURCE_DIR}/build_tools/autogen_ltc_backend.yaml
  ${PROJECT_SOURCE_DIR}/include/torch-mlir/Dialect/Torch/IR/GeneratedTorchOps.td
  ${LTC_BACKEND_DEPENDS}
  ${TORCHGEN_DIR}/gen_backend_stubs.py
  ${TORCHGEN_DIR}/gen_lazy_tensor.py
  ${TORCHGEN_DIR}/api/lazy.py
  ${TORCHGEN_DIR}/dest/lazy_ir.py
  COMMENT "Generating Lazy Tensor Core IR Nodes"
)
add_custom_target(
  torch_mlir_ltc_backend_generated ALL
  DEPENDS
  ${TORCH_MLIR_BINARY_DIR}/generated_backend.hash
  ${LTC_GENERATED}
)

add_library(torch_mlir_ltc_backend SHARED
  ${LTC_GENERATED}
  ${LTC_BACKEND_DEPENDS}
  backend_impl.cpp
  dynamic_ir.cpp
  mlir_node.cpp
  ops/device_data.cpp
  ops/generic.cpp
  utils/jit_utils.cpp
  utils/tensor_utils.cpp
)
target_compile_features(torch_mlir_ltc_backend PRIVATE cxx_std_17)

add_dependencies(torch_mlir_ltc_backend
  TorchMLIRJITIRImporter
  torch_mlir_ltc_backend_generated
)
target_link_libraries(torch_mlir_ltc_backend
  TorchMLIRAggregateCAPI
  TorchMLIRJITIRImporter
  ${TORCH_LIBRARIES}
)

message(STATUS "TORCH_CXXFLAGS=${TORCH_CXXFLAGS} -Wno-pedantic")
set_target_properties(torch_mlir_ltc_backend PROPERTIES
  LIBRARY_OUTPUT_DIRECTORY "${TORCH_MLIR_PYTHON_PACKAGES_DIR}/torch_mlir/torch_mlir/_mlir_libs"
  OUTPUT_NAME lib_torch_mlir_ltc
  PREFIX ""
  SUFFIX ".so"
  CXX_VISIBILITY_PRESET "hidden"
  COMPILE_FLAGS "${TORCH_CXXFLAGS} -Wno-pedantic"
  LINK_FLAGS "-rdynamic"
)

# Copy header files into python package

add_custom_command(
        TARGET torch_mlir_ltc_backend POST_BUILD
        COMMAND mkdir -p
                ${TORCH_MLIR_PYTHON_PACKAGES_DIR}/torch_mlir/torch_mlir/base_lazy_backend/generated/)

add_custom_command(
        TARGET torch_mlir_ltc_backend POST_BUILD
        COMMAND cp
                ${PROJECT_SOURCE_DIR}/python/torch_mlir/csrc/base_lazy_backend/*.h
                ${TORCH_MLIR_PYTHON_PACKAGES_DIR}/torch_mlir/torch_mlir/base_lazy_backend/)

add_custom_command(
        TARGET torch_mlir_ltc_backend POST_BUILD
        COMMAND cp
                ${PROJECT_SOURCE_DIR}/python/torch_mlir/csrc/base_lazy_backend/generated/*.h
                ${TORCH_MLIR_PYTHON_PACKAGES_DIR}/torch_mlir/torch_mlir/base_lazy_backend/generated/)

add_custom_command(
        TARGET torch_mlir_ltc_backend POST_BUILD
        COMMAND mkdir -p
                ${TORCH_MLIR_PYTHON_PACKAGES_DIR}/torch_mlir/torch_mlir/base_lazy_backend/ops/)

add_custom_command(
        TARGET torch_mlir_ltc_backend POST_BUILD
        COMMAND cp
                ${PROJECT_SOURCE_DIR}/python/torch_mlir/csrc/base_lazy_backend/ops/*.h
                ${TORCH_MLIR_PYTHON_PACKAGES_DIR}/torch_mlir/torch_mlir/base_lazy_backend/ops/)

add_custom_command(
        TARGET torch_mlir_ltc_backend POST_BUILD
        COMMAND mkdir -p
                ${TORCH_MLIR_PYTHON_PACKAGES_DIR}/torch_mlir/torch_mlir/base_lazy_backend/utils/)

add_custom_command(
        TARGET torch_mlir_ltc_backend POST_BUILD
        COMMAND cp
                ${PROJECT_SOURCE_DIR}/python/torch_mlir/csrc/base_lazy_backend/utils/*.h
                ${TORCH_MLIR_PYTHON_PACKAGES_DIR}/torch_mlir/torch_mlir/base_lazy_backend/utils/)
