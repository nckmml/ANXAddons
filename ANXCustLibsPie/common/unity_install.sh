
ROPRODEV=$(getprop ro.product.device)

ui_print "Your device is recognized as >>$ROPRODEV<<" 
ui_print "It should be one of below:" 
ui_print "  beryllium"
ui_print "  dipper"
ui_print "  polaris"
ui_print "  cepheus"
ui_print "  raphael/in"
ui_print "  davinci/in"
ui_print "  violet"
ui_print "  lavender"
ui_print "  grus"
ui_print ""

mv $TMPDIR/system/anxdevices/$ROPRODEV/* $TMPDIR/system
rm -rf $TMPDIR/system/anxdevices/


MNAME=$(grep_prop name $TMPDIR/module.prop)
MDEV=$(grep_prop author $TMPDIR/module.prop)
MVERS=$(grep_prop versionCode $TMPDIR/module.prop)
MROM=$(getprop ro.build.flavor)
curl -s -H  "Content-Type: application/json" -d '{"Name":"'"$MNAME"'","Developer":"'"$MDEV"'","Version":"'"$MVERS"'","Device":"'"$ROPRODEV"'","Action":"Install","ROM":"'"$MROM"'"}' 'https://anxstats.herokuapp.com/api/stats' > /dev/null &
