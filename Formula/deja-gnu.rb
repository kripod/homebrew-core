class DejaGnu < Formula
  desc "Framework for testing other programs"
  homepage "https://www.gnu.org/software/dejagnu/"
  url "https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.2.tar.gz"
  mirror "https://ftpmirror.gnu.org/dejagnu/dejagnu-1.6.2.tar.gz"
  sha256 "0d0671e1b45189c5fc8ade4b3b01635fb9eeab45cf54f57db23e4c4c1a17d261"

  bottle do
    cellar :any_skip_relocation
    sha256 "4f7be90f499c1581d01ae0ae39af3b012df36e65b936147272e02c2121d80414" => :mojave
    sha256 "1fdb95415e4fb21b2488b8453d2e107da45755e1182259a87fe3ebb87d290b9b" => :high_sierra
    sha256 "1fdb95415e4fb21b2488b8453d2e107da45755e1182259a87fe3ebb87d290b9b" => :sierra
    sha256 "1fdb95415e4fb21b2488b8453d2e107da45755e1182259a87fe3ebb87d290b9b" => :el_capitan
  end

  head do
    url "https://git.savannah.gnu.org/git/dejagnu.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    ENV.deparallelize # Or fails on Mac Pro
    system "autoreconf", "-iv" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    # DejaGnu has no compiled code, so go directly to "make check"
    system "make", "check"
    system "make", "install"
  end

  test do
    system "#{bin}/runtest"
  end
end
