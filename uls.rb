class Uls < Formula
  desc "Create lexical analyzers for your language"
  homepage "https://github.com/link2next/uls"
  url "https://github.com/link2next/uls/tarball/v1.8.0"
  version "1.8.0"
  sha256 "005ddf1f36288ced2f8e5f4e8e07a0bbbb8dbe0a06fea925ff0e50a146d7ec63"

  bottle :unneeded

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "flex" => :build
  depends_on "bison" => :build
  depends_on "help2man" => :build

  def install
    ENV.deparallelize
    system "./configure", "--prefix=#{prefix}", "--with-etc-dir=#{prefix}/etc"
    system "make"
    system "make", "install"
  end

  def post_install
    system "#{bin}/ls", "#{prefix}/etc"
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    (testpath/"test_hello.c").write <<~EOS
    #include <stdio.h>
    int main(int argc, char* argv[]) {
      printf("hello world!\n");
      return 0;
    }
    EOS
    system ENV.cc, "-o", "test_hello", ENV.cflags, "-I#{include}", "test_hello.c"
    system "./test_hello"
  end
end
