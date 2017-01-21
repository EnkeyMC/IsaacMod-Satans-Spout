local mod = RegisterMod("Satan's Spout", 1);

-- Satan's Spout
local satansSpout = Isaac.GetItemIdByName("Satan's Spout");
local spoutEntityID = 12666;

function use_satansSpout()
  local player = Isaac.GetPlayer(0);
  local position = Isaac.GetFreeNearPosition(player.Position, 1);
  local entity = Isaac.Spawn(spoutEntityID, 0, 0, position, Vector(0,0), player);
  
  return true;
end

function shootBrimstone(spoutEntity)
  local player = Isaac.GetPlayer(0)
  local laser = EntityLaser.ShootAngle(1, spoutEntity.Position, 0, 10, Vector(LaserOffset.LASER_BRIMSTONE_OFFSET, LaserOffset.LASER_BRIMSTONE_OFFSET), player)
  laser.DisableFollowParent = true
  laser.CollisionDamage = player.Damage
end

function satansSpoutUpdate()
  local frames = Isaac.GetFrameCount()
  local entities = Isaac.GetRoomEntities()
  
  for i = 1, #entities do      
    if entities[i].Type == spoutEntityID then
      entities[i]:ToNPC().CanShutDoors = false
      if entities[i].FrameCount % 180 == 0 then
        shootBrimstone(entities[i])
      end
    end
  end
end


mod:AddCallback(ModCallbacks.MC_USE_ITEM, use_satansSpout, satansSpout)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, satansSpoutUpdate)