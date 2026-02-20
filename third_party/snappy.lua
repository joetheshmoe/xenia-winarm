group("third_party")
project("snappy")
  uuid("bb143d61-3fd4-44c2-8b7e-04cc538ba2c7")
  kind("StaticLib")
  language("C++")

  files({
    "snappy/snappy-internal.h",
    "snappy/snappy-sinksource.cc",
    "snappy/snappy-sinksource.h",
    "snappy/snappy-stubs-internal.cc",
    "snappy/snappy-stubs-internal.h",
    "snappy/snappy-stubs-public.h",
    "snappy/snappy.cc",
    "snappy/snappy.h",
  })

  local snappy_dir = path.getabsolute("snappy")
  if not os.isfile(path.join(snappy_dir, "snappy-stubs-public.h")) then
    local cmake_args = "-DSNAPPY_BUILD_TESTS=OFF -DSNAPPY_BUILD_BENCHMARKS=OFF"
    local target_arch = _OPTIONS["arch"] or os.targetarch()
    if os.istarget("windows") then
      if target_arch == "arm64" or target_arch == "ARM64" then
        cmake_args = cmake_args .. " -A ARM64"
      else
        cmake_args = cmake_args .. " -DSNAPPY_REQUIRE_AVX=ON"
      end
    else
      if target_arch ~= "arm64" and target_arch ~= "ARM64" then
        cmake_args = cmake_args .. " -DSNAPPY_REQUIRE_AVX=ON"
      end
    end
    prebuildcommands({
      "cmake " .. cmake_args .. " " .. snappy_dir .. " -B" .. snappy_dir
    })
  end
