
ROPRODEV=$(getprop ro.product.device)

ui_print "Your device is recognized as >>$ROPRODEV<<" 
ui_print ""

if [ $ROPRODEV = ginkgo ] || [ $ROPRODEV = lavender ] || [ $ROPRODEV = willow ]
then
    mv $TMPDIR/system/samsung/* $TMPDIR/system
elif [ $ROPRODEV = laurel_sprout ]
then
    mv $TMPDIR/system/laurel_sprout/* $TMPDIR/system
elif [ $ROPRODEV = curtana ]
then
    mv $TMPDIR/system/curtana/* $TMPDIR/system
else
    mv $TMPDIR/system/imx/* $TMPDIR/system
fi

rm -rf $TMPDIR/system/imx/
rm -rf $TMPDIR/system/samsung/
rm -rf $TMPDIR/system/laurel_sprout/
rm -rf $TMPDIR/system/curtana/


MNAME=$(grep_prop name $TMPDIR/module.prop)
MDEV=$(grep_prop author $TMPDIR/module.prop)
MVERS=$(grep_prop versionCode $TMPDIR/module.prop)
MROM=$(getprop ro.build.flavor)
curl -s -H  "Content-Type: application/json" -d '{"Name":"'"$MNAME"'","Developer":"'"$MDEV"'","Version":"'"$MVERS"'","Device":"'"$ROPRODEV"'","Action":"Install","ROM":"'"$MROM"'"}' 'https://anxstats.herokuapp.com/api/stats' > /dev/null &
