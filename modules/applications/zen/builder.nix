{ lib, ... }: let 
  itemToContainer = value : {
    color = value.color;
    icon = value.icon;
    id = value.id;
  };
  toContainers = items : builtins.listToAttrs ( map ( { key, ... } @ value: { name = key; value = itemToContainer value; } ) items ) ;
  itemToSpace = index : value : {
    name = value.key;
    value = {
      id = value.uuid;
      icon = value.spaceIcon;
      container = value.id;
      position = index * 1000;
    };
  };
  itemsToSpaces = items : lib.imap1 itemToSpace items;
  toSpaces = items : builtins.listToAttrs (itemsToSpaces items);
  itemToPin = container : { folderId ? null, ... } @ pin : {
    name = pin.url;
    value = {
      title = pin.title;
      id = pin.uuid;
      url = pin.url;
      container = container.id;
      workspace = container.uuid;
      editedTitle = true;
      folderParentId = folderId;
    };
  };
  itemToFolder = container : pin : {
    name = pin.title;
    value = {
      title = pin.title;
      id = pin.uuid;
      container = container.id;
      workspace = container.uuid;
      isGroup = true;
    };
  };
  putPositions = items : (lib.imap1 (index : { name, value} : { name = name; value = value // { position = index * 1000; }; })) items;
  containerToPins = acc : { pins ? [], folders ? [], ... } @ container : acc ++ map (itemToFolder container) folders ++ map (itemToPin container) pins;
  itemsToPins = items : putPositions (builtins.foldl' containerToPins [] items);
  toPins = items : builtins.listToAttrs (itemsToPins items);
  multiPins = { title, baseUrl, sites, folderId ? null } : map (site : {
    title = "${title} - ${site.title}";
    url = baseUrl site.url;
    uuid = site.uuid;
    folderId = folderId;
  }) sites;
in{
  toContainers = toContainers;
  toSpaces = toSpaces;
  toPins = toPins;
  multiPins = multiPins;
}
