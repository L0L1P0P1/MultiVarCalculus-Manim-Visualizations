{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }: 
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs {system = "x86_64-linux"; config.allowBroken=true;};
	in
	{
		devShells.${system}.default = 
		pkgs.mkShell {
			allowBroken = true;
			buildInputs = with pkgs; [
				manim

				(python312.withPackages (python-pkgs: with python-pkgs; [
					pandas
					jupyter
					numpy
					seaborn
					scipy
					matplotlib
					requests
					beautifulsoup4
				]))
			];

			LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib";
			shellHook = ''
				zsh 
				'';
		};
	};
}
