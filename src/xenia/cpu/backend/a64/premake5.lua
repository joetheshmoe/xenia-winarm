project_root = "../../../../.."
include(project_root.."/tools/build")

group("src")
project("xenia-cpu-backend-a64")
  uuid("495f3f3e-f5e8-489a-bd0f-289d0495bc08")
  kind("StaticLib")
  language("C++")
  cppdialect("C++20")

  filter("architecture:arm64 or architecture:ARM64")
    links({
      "fmt",
      "xenia-base",
      "xenia-cpu",
    })

    sysincludedirs({
      project_root.."/third_party/oaknut/include",
    })
    includedirs({
      project_root.."/third_party/oaknut/include",
    })

    filter({"architecture:arm64 or architecture:ARM64", "toolset:clang or toolset:gcc"})
      externalincludedirs({
        project_root.."/third_party/oaknut/include",
      })
      -- Also explicitly disable the warning for third-party code
      buildoptions({
        "-Wno-shorten-64-to-32",
      })
    filter({"architecture:arm64 or architecture:ARM64", "toolset:msc"})
      includedirs({
        project_root.."/third_party/oaknut/include",
      })
    filter("architecture:arm64 or architecture:ARM64")
      local_platform_files()
  filter({})
