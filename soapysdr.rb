class Soapysdr < Formula
  desc "Vendor and platform neutral SDR support library"
  homepage "https://github.com/pothosware/SoapySDR/wiki"
  head "https://github.com/pothosware/SoapySDR.git"
  url "https://github.com/pothosware/SoapySDR/archive/soapy-sdr-0.7.0.tar.gz"
  sha256 "cb2344be77f4d04f6cbafa183c7e39a2e6eb0da39c98fa77e9d60686c4e81e52"

  depends_on "cmake" => :build
  depends_on "swig" => :build
  depends_on "python2" => :optional
  depends_on "python" => :recommended

  def install

    args = []

    if build.with?("python2")
        args += ["-DENABLE_PYTHON=ON"]
        args += ["-DUSE_PYTHON_CONFIG=ON"]
    else
        args += ["-DENABLE_PYTHON=OFF"]
    end

    if build.with?("python")
      args += ["-DENABLE_PYTHON3=ON"]
    else
      args += ["-DENABLE_PYTHON3=OFF"]
    end

    if !(build.head?)
      args += ["-DSOAPY_SDR_EXTVER=release"]
    end

    args += %W[-DSOAPY_SDR_ROOT='#{HOMEBREW_PREFIX}']

    mkdir "build" do
      args += std_cmake_args
      system "cmake", "..", *args
      system "make", "install"
    end
  end
end
