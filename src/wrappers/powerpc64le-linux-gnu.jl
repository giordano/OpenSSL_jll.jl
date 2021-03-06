# Autogenerated wrapper script for OpenSSL_jll for powerpc64le-linux-gnu
export libcrypto, libssl, openssl

## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"
LIBPATH_default = ""

# Relative path to `libcrypto`
const libcrypto_splitpath = ["lib", "libcrypto.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libcrypto_path = ""

# libcrypto-specific global declaration
# This will be filled out by __init__()
libcrypto_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libcrypto = "libcrypto.so.1.1"


# Relative path to `libssl`
const libssl_splitpath = ["lib", "libssl.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libssl_path = ""

# libssl-specific global declaration
# This will be filled out by __init__()
libssl_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libssl = "libssl.so.1.1"


# Relative path to `openssl`
const openssl_splitpath = ["bin", "openssl"]

# This will be filled out by __init__() for all products, as it must be done at runtime
openssl_path = ""

# openssl-specific global declaration
function openssl(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(PATH, ':', ENV["PATH"])
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        LIBPATH_base = get(ENV, LIBPATH_env, expanduser(LIBPATH_default))
        if !isempty(LIBPATH_base)
            env_mapping[LIBPATH_env] = string(LIBPATH, ':', LIBPATH_base)
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(openssl_path)
    end
end


"""
Open all libraries
"""
function __init__()
    global artifact_dir = abspath(artifact"OpenSSL")

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    global libcrypto_path = normpath(joinpath(artifact_dir, libcrypto_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libcrypto_handle = dlopen(libcrypto_path)
    push!(LIBPATH_list, dirname(libcrypto_path))

    global libssl_path = normpath(joinpath(artifact_dir, libssl_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libssl_handle = dlopen(libssl_path)
    push!(LIBPATH_list, dirname(libssl_path))

    global openssl_path = normpath(joinpath(artifact_dir, openssl_splitpath...))

    push!(PATH_list, dirname(openssl_path))
    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(vcat(LIBPATH_list, [joinpath(Sys.BINDIR, Base.LIBDIR, "julia"), joinpath(Sys.BINDIR, Base.LIBDIR)]), ':')

    
end  # __init__()

