{ lib, ... }: let 
  itemToContainer = value : {
    color = value.color;
    icon = value.icon;
    id = value.id;
  };
  toContainers = items : builtins.listToAttrs ( map ( { key, ... } @ value: { name = key; value = itemToContainer value; } ) items ) ;
  itemToSpace = index : { theme ? null, ... }@value : {
    name = value.key;
    value = {
      id = value.uuid;
      icon = value.spaceIcon;
      container = value.id;
      position = index * 1000;
      theme.type = "gradient";
      theme.colors = theme;
    };
  };
  itemsToSpaces = items : lib.imap1 itemToSpace items;
  toSpaces = items : builtins.listToAttrs (itemsToSpaces items);
  itemToPin = container : { folderId ? null, isEssential ? false, isGroup ? false, url ? null, ... } @ pin : {
    name = (if isGroup then pin.title else pin.url);
    value = {
      title = pin.title;
      id = pin.uuid;
      url = url;
      container = container.id;
      workspace = container.uuid;
      editedTitle = true;
      folderParentId = folderId;
      isEssential = isEssential;
      isGroup = isGroup;
    };
  };
  itemToFolder = pin : {
    title = pin.title;
    uuid = pin.uuid;
    isGroup = true;
  };
  putPositions = items : (lib.imap1 (index : { name, value} : { name = name; value = value // { position = index * 1000; }; })) items;
  containerToPins = acc : { pins ? [], ... } @ container : acc ++ map (itemToPin container) pins;
  itemsToPins = items : putPositions (builtins.foldl' containerToPins [] items);
  toPins = items : builtins.listToAttrs (itemsToPins items);
  putFolder = { baseUrl ? null, ... } @ folder: { url, title ? url, ... } @ site: site // { title = title; folderId = folder.uuid; url = (if isNull baseUrl then site.url else baseUrl site.url); };
  mkFolder = folder: [ (itemToFolder folder) ] ++ map (putFolder folder) folder.sites;
in{
  toContainers = toContainers;
  toSpaces = toSpaces;
  toPins = toPins;
  mkFolder = mkFolder;
}
