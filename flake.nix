{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }: 
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in
	{
		devShells.${system}.default = 
		pkgs.mkShell {
			buildInputs = with pkgs; [
				python312
				poetry
				manim

				# libgccjit
				# libgcc
				# (python312.withPackages (python-pkgs: with python-pkgs; [
				# 	pandas
				# 	joblib
				# 	jupyter
				# 	numpy
				# 	seaborn
				# 	scipy
				# 	matplotlib
				# 	requests
				# 	beautifulsoup4
				#
				# ]))
			];

			LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib";
			shellHook = ''
				zsh
				'';
		};
	};
}
