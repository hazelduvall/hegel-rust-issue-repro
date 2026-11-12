{
  pkgs,
  rust-toolchain,
  ...
}:
pkgs.mkShell.override
  {
    stdenv = pkgs.gcc16Stdenv;
  }
  {
    buildInputs = [
      rust-toolchain
    ];
    nativeBuildInputs = (
      with pkgs;
      [
        # For debugging
        vscode-extensions.vadimcn.vscode-lldb.adapter
        # For developing
        cargo-nextest
        cargo-udeps
        cargo-watch
      ]
    );
  }
