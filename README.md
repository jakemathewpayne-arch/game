# Mutant Lab V5

Roblox mutant collecting game: Roll -> Buy -> Equip -> Place -> Collect.

## Install and play
1. Save a backup of your old Roblox Studio place and work in a test place.
2. In Roblox Studio's **Game Settings > Security**, enable **Allow HTTP Requests**. For test saving in a published test experience, enable **Studio Access to API Services**.
3. In the Studio **Command Bar** in Edit mode paste:

```lua
loadstring(game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/jakemathewpayne-arch/game/main/installer.lua"))()
```

4. Press Enter (or Ctrl+Enter as required), save the place, and press Play.
5. Stand near ROLL and press E. The machine previews different 3D mutants and then offers Buy or Skip. Bought mutants enter the Roblox hotbar. Equip one and press E at a free display pad. Walk to COLLECT to claim accumulated cash.

## Gameplay
- 4 starting pads, 2 additional pads per rebirth, up to 10.
- 6 mutant types; higher rarity earns more cash per second.
- Luck upgrades and multi-roll upgrades.
- V5 uses its own DataStore, `MutantLabV5_1`, so old V3/V4 progress isn't overwritten.
- Rerunning the installer updates V5 map and scripts. Test new versions before publishing.

## Current limitations
Prototype not yet playtested end-to-end. Shared world with client-side creature visuals; player-specific plots and server-owned Tools are not implemented. Simple procedural creature meshes. Roblox hosts the playable game; GitHub stores source code. The repository is public.

**Security:** This one-liner executes remote code with Studio editing privileges. Review the latest installer source before running and only trust updates to your own repository.
