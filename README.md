# Vector_field_differential_eqs
Processing sketch using particles to trace paths in a vector field
<br>

If you would like to edit the equations, go to the PVector fieldFunc(...) function.
The first 6 lines of this function are simply a transformation/scaling to a cartesian plane
<br>

The variables delFOverDelX and delFOverDelY are what's important.
Set them in terms of x and y.
<br>

If you would like to graph the function on say, desmos, simply integrate both equations with respect to their respective variable (x or y)
<br>

The program is capable of plotting 1st derivatives (velocity) and 2nd derivatives (accleration)
<br>

**Examples**
<br>
(Hue represents angle)

df/dx = sin(x)-cos(x)
<br>
df/dy = cos(y)-sin(y)
<br>
![plot image](https://i.imgur.com/s0JyUwU.jpg)
<br>
<br>

df/dx = x*(1-x)
<br>
df/dy = y*(1-y)
<br>

![plot image](https://i.imgur.com/YKoDfKk.jpg)
<br>
<br>

df/dx = sin(2.3x) + ycos(x)
<br>
df/dy = xsin(y) - cos(2.3y)
<br>
![plot image](https://i.imgur.com/g3RYBa8.jpg)
<br>
<br>

df/dx = -x*abs(x) - y
<br>
df/dy = -y*abs(y) - x
<br>
![plot image](https://i.imgur.com/P1sAnsx.png)
<br>
<br>
