import Lake
open Lake DSL

package «evm» where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩, -- pretty-prints `fun a ↦ b`
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩]

lean_lib «Evm» where
  -- add library configuration options here

@[default_target]
lean_exe «evm» where
  root := `Main


require mathlib from git "git@github.com:henry-hz/mathlib4.git"@"master"
