#!/bin/sh

# ignore-tidy-linelength

set -ex

case "$(uname -m)" in
    x86_64)
        url="https://ci-mirrors.rust-lang.org/rustc/2026-06-19-sccache-v0.16.0-x86_64-unknown-linux-musl.tar.gz"
        archive_path="sccache-v0.16.0-x86_64-unknown-linux-musl/sccache"
        ;;
    aarch64)
        url="https://ci-mirrors.rust-lang.org/rustc/2026-06-19-sccache-v0.16.0-aarch64-unknown-linux-musl.tar.gz"
        archive_path="sccache-v0.16.0-aarch64-unknown-linux-musl/sccache"
        ;;
    *)
        echo "unsupported architecture: $(uname -m)"
        exit 1
esac

tmp_dir="$(mktemp -d)"
curl -fo "${tmp_dir}/sccache.tar.gz" "${url}"
tar -xvf "${tmp_dir}/sccache.tar.gz" --strip-components 1 -C "${tmp_dir}" "${archive_path}"
mv "${tmp_dir}/sccache" /usr/local/bin/sccache
rm -rf "${tmp_dir}"
chmod +x /usr/local/bin/sccache
