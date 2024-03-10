import Lake
open Lake DSL

package «lab» where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩, -- pretty-prints `fun a ↦ b`
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩]

lean_lib «Lab» where
  -- add library configuration options here

@[default_target]
lean_exe «lab» where
  root := `Main


require mathlib from git "git@github.com:henry-hz/mathlib4.git"@"master"
