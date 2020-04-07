c=createComboBox(MainForm.gbScanOptions)

c.Style='csDropDownList'
c.Items.add('All')
c.ItemIndex=0


c.Align=alTop
c.BorderSpacing.Left=6
c.BorderSpacing.Right=6
c.BorderSpacing.Bottom=2

local modulelist

c.OnDropDown=function(d)
  --fill the list
  while c.Items.Count>1 do
    c.Items.delete(1)
  end

  modulelist=enumModules()
  local i
  for i=1, #modulelist do
    c.Items.Add(modulelist[i].Name)
  end
end

c.OnSelect=function(d)
  if c.ItemIndex>=1 then
    MainForm.FromAddress.Text=string.format("%.16x",modulelist[c.ItemIndex].Address)
    if modulelist[c.ItemIndex].Size==nil then
      modulelist[c.ItemIndex].Size=getModuleSize(modulelist[c.ItemIndex].Name)
    end
    MainForm.ToAddress.Text=string.format("%.16x",modulelist[c.ItemIndex].Address+modulelist[c.ItemIndex].Size)
  else
    MainForm.FromAddress.Text="0000000000000000"
    MainForm.ToAddress.Text="7fffffffffffffff"
  end
end

c.Enabled=false
