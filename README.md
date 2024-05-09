# DScooldown
Small tooll which allows you to reduce 2h cooldown period when usign Oracle Dynamic Scaling on ExaCS (Doc ID 2719916.1)

If you are using Oracle Dynamic Scaling on your Exadata in OCI you have default 120 min cooldown period after each scale-up before DS can do scale-down.
There is no option to change the 120 mins period so you need to action in a bit custom way. 

Here is the solution:

Assume you have --acfs parameter set as:
```
--acfs /acfs01/ODYS
```
Then copy DScooldown.sh to that dir.

To use this tool, simple add this line to root crontab: 
```
*/5 * * * * /acfs01/ODYS/DScooldown.sh >/dev/null 2>&1
```
