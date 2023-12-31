### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 4e4a8aec-cb96-41b1-b5da-c9510e0fe09e
begin
	using CommonMark, ImageIO, FileIO, ImageShow
	using PlutoUI
	using Plots, PlotThemes, LaTeXStrings, Random
	using PGFPlotsX
	using SymPy
	using HypertextLiteral
	using ImageTransformations
	using Colors
end

# ╔═╡ eb5cb250-0691-11ee-0fa7-63ff4496bc57
@htl("""
<style>
@import url("https://mmogib.github.io/math102-julia/custom.css");
</style>
""")

# ╔═╡ 9e13821e-02da-44ca-a89f-d767a1b20fdd
TableOfContents(title="MATH101")

# ╔═╡ fc618c32-0288-4ac8-a372-067abfca73d1
cm"""
<div style="color:red;font-size:16pt;">

[Syllabus](https://www.dropbox.com/s/k6elvcvqdq25tlz/Math%20101-Syllabus%20Term%20223R1.pdf?raw=1)

</div>
"""

# ╔═╡ 8d6ed1ef-7e76-4b53-a366-f06c67987ec2

# $(Resource("https://www.dropbox.com/s/bjk5ljmiw9bc6h7/qrcode_itempool.com.png?raw=1",:width=>300))
cm"""
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>300))

</div>
"""

# ╔═╡ 31a33b85-4cf2-4263-a2a8-9e3f492e73de
md"""
# 2.1: A Preview of Calculus
__Objectives__
> - Understand what calculus is and how it compares with precalculus.
> - Understand that the tangent line problem is basic to calculus.
> - Understand that the area problem is also basic to calculus.

"""

# ╔═╡ 7cf53b88-c492-41a4-98b1-1b96f2605e6c
cm"""
<div style="color:red;font-size:16pt;">
intro.
</div>
"""

# ╔═╡ d69e90f6-43fe-4bc4-b22b-7b799b492905
md"""
## What is Calculus?
"""


# ╔═╡ dd289ebf-aa4d-4436-8690-5a93cbad046f
md"""
## The Tangent Line Problem
"""

# ╔═╡ af42a2d7-b304-4845-817a-c98fa1f8964b
begin
	local f1(x)=0.2x^2+1
	local df1(x)=0.4x
	local p1= plot(x->f1(x),
		aspect_ratio=1,
		c=:blue,
		linewidth=2,
		xlimits=(-0.9,5),
		xticks=([1,2,3,4,5],["","","","",""]),
		yticks=([1,2,3,4,5,6],["","","","",""]),
		annotations=[
				(5,0.2,L"x"),
				(0.2,6,L"y"),
				(1,0.2,L"c"),
				(3,3.5,L"y=f(x)"),
				(1,f1(1)-0.01,L"\bullet"),
				(0.8,f1(1)+0.35,text(L"P(c,f(c))",12)),
		],
		frame_style=:origin, 
		label=:none)
	plot!(p1,x->df1(1)*(x-1)+f1(1),c=:black,label=nothing)
		
	cm"""
	
	__What is the slope of the line (called *tangent line*) passing through the point ``P(c,f(c))``?__
	$p1
	
	"""
end

# ╔═╡ 172631df-e61d-4c04-9135-66ea58c07786
begin
	dxSlider = @bind Δx1 Slider(0:0.1:4, default=4)
	cm"""
	``\Delta x``  $dxSlider
	"""
end

# ╔═╡ 5b818cd4-3930-443f-acd4-96a1dd09084d
begin
	f2(x)=0.2x^2+1
	df2(x)=0.4x
	slope1(d) =(f2(1+d)-f2(1))/d
	p2= plot(x->f2(x),
		aspect_ratio=1,
		xlimits=(-4,6),
		ylimits=(-0.1,8),
		c=:blue,
		linewidth=2,
		xticks=([1,2,3,4,5],["","","","",""]),
		yticks=([1,2,3,4,5,6,7,8],["","","","",""]),
		annotations=[
				(5,0.2,L"x"),
				(0.2,8,L"y"),
				(1,0.2,L"c"),
				(4.5,3.5,L"y=f(x)"),
				(1,f2(1)-0.01,L"\bullet"),
				(0.8,f2(1)+0.35,text(L"P(c,f(c))",8)),
				(1+Δx1,f2(1+Δx1)-0.35,text(L"Q(c+\Delta x,f(c+\Delta x))",8)),
				(1+Δx1,f2(1+Δx1)-0.01,L"\bullet"),
		],
		frame_style=:origin, 
		label=:none)
	plot!(p2,x->(slope1(Δx1))*(x-1)+f2(1),c=:green,label=nothing)
	plot!(p2,x->df2(1)*(x-1)+f2(1),c=:black,label=nothing)
		
	cm"""
	__Find the equation of the secant line__
	$p2
	```math
	\color{green}{
	\text{m}_{sec}=\frac{f(c+\Delta x)-f(c)}{\Delta x}
	}
	```
	"""
end

# ╔═╡ abd33bc9-d00c-4eb2-81fd-b8431ae6288d
begin
	dxSlider2 = @bind Δx2 Slider(0.0:0.1:4, default=4)
	cm"""
	``\Delta x``  $dxSlider2
	"""
end

# ╔═╡ c9c7c4bd-0de4-4878-a00b-9bce01654e1b
begin
	
	p3= plot(x->f2(x),
		aspect_ratio=1,
		xlimits=(-4,6),
		ylimits=(-0.1,8),
		c=:blue,
		linewidth=2,
		xticks=([1,2,3,4,5],["1","2","3","4","5"]),
		yticks=([1,2,3,4,5,6,7,8],["1","2","3","4","5","6","7","8"]),
		annotations=[
				(5,0.2,L"x"),
				(0.2,8,L"y"),
				(1,0.2,L"c"),
				(1,f2(1)-0.01,L"\bullet"),
				(2,f2(2)+4,L"f(x)=\frac{x^2}{5}+1"),
				(0.8,f2(1)+0.35,text(L"P",8)),
				(1+Δx2,f2(1+Δx2)-0.35,text(L"Q",8)),
				(1+Δx2,f2(1+Δx2)-0.01,L"\bullet"),
		],
		frame_style=:origin, 
		label=:none)
	plot!(p3,x->(slope1(Δx2))*(x-1)+f2(1),c=:green,label=nothing)
	plot!(p3,x->df2(1)*(x-1)+f2(1),c=:black,label=nothing)
		
	cm"""
	Example: __Find the equation of the secant line__
	$p3
	``
	\displaystyle
	\text{m}_{sec}=\frac{f(c+\Delta x)-f(c)}{\Delta x} =
	``
	<span style="color:green;">$(slope1(Δx2))</span>
	"""
end

# ╔═╡ 8995c3bf-2259-4f68-9ac9-e620a08ce7f3
md"""
## The Area Problem

"""

# ╔═╡ 7cf7773b-92b6-466d-b793-c34b46691f79


# ╔═╡ e49b3b27-5fe2-4874-bad2-815aaa5b2ebd
cm"""
__Find the area under the curve?__
"""

# ╔═╡ 99374bba-df51-4b6c-976d-2f54c3167367
begin
    ns1 = @bind n1 Slider(2:100, show_value=true, default=4)
    as1 = @bind a1 NumberField(0:1)
    bs1 = @bind b1 NumberField(a1+2:10,default=6)
    lrs1 = @bind lr Select(["l" => "Left", "r" => "Right", "m" => "Midpoint", "rnd" => "Random"])

    md"""
    n = $ns1  a = $as1  b = $bs1 method = $lrs1

    """
end

# ╔═╡ 0d03b351-8d6c-41b8-a270-8277ed4c280b
begin
   		f3(x) = x + sin(x)
        Δx3 = (b1 - a1) / n1
        xx1 = a1:0.1:b1

        # plot(f;xlim=(-2π,2π), xticks=(-2π:(π/2):2π,["$c π" for c in -2:0.5:2]))

        # recs= [rect(sample(p,Δx),Δx,p,f) for p in partition]
        # pp1=plot(xx1,f.(xx1);legend=nothing)
        pp1 = plot(xx1, f3.(xx1), fillrange=zero, fillalpha=0.35, c=:blue, framestyle=:origin, label=nothing)
        anck1 = (b1 - a1) / 2
        anck2 = f3(anck1) / 2
        annotate!(pp1, [(anck1, anck2, L"$S$", 12)])
        annotate!(pp1, [(anck1, f3(anck1)+0.2, L"y=f(x)", 12)])
    
end

# ╔═╡ 1cc33cad-c78e-4f5c-993c-af477781549f
cm"""
<div style="color:red;font-size:16pt;">
outro.
</div>
"""

# ╔═╡ 66751f8f-e505-47e2-9db2-4d68653acca0
md"""
# 2.2: Finding Limits Graphically and Numerically
__Objectives__
> - Estimate a limit using a __numerical__ or __graphical approach__.
> - Learn different ways that a limit can fail to exist.
> - <s>Study and use a formal definition of limit</s>.


"""

# ╔═╡ 46db1f9c-5944-4647-9ee9-b24065303325
md"""
## An Introduction to Limits
Consider the function
```math
f(x) = \frac{x^3-1}{x-1}
```
"""

# ╔═╡ c2fa6116-3b80-4843-b3ad-b6e035e341ba
begin
	Δx4 = 0.5
h1Silder = @bind h1 Slider(vcat(0:Δx4:2,2.1:0.1:3.9,3.90:0.01:4),default=0, show_value=true)
	sideSlider = @bind side1 Select([:lft=>"Left",:rgt=>"Right"],default=:lft)
cm"""
``\Delta x=`` $h1Silder   ``\quad\quad   x`` __approaches__ ``1`` from $sideSlider
"""
end

# ╔═╡ 9934a07b-29d3-4e1f-abc1-05ddd213d216
begin
	f4(x)= (x==1) ? "?" : (x^3-1)/(x-1)
	
	annotations = if (-3+h1 == 1 || 5-h1 == 1)
			[(1,3,text(L"\bullet",:white)),(1,3,text(L"\bigcirc"))] 
	else 
		(side1==:lft) ? [
			(-3+h1,f4(-3+h1),L"\bullet"),
			(-3+h1,f4(-3+h1)+1.95,text("($(-3+h1),$(f4(-3+h1)))",7)),
		] : [
			(5-h1,f4(5-h1),L"\bullet"),
			(5-h1+0.95,f4(5-h1),text("($(5-h1+0.5),$(f4(5-h1)))",7)),
		]
	end
	p2_2_2_1 = plot(
		x->f4(x),
		frame_style=:origin,
		label=:none,
		c=:blue,
		linewidth=2,
		xlimits=(-3,5),
		size=(300,200),
		xticks=[-3,-2,-1,0,1,2,3,4],
		annotations=annotations
	)
	x5 = if (h1>=3.91)
		vcat(0:Δx4:2,2.1:0.1:3.9,3.91:0.01:h1)
	elseif (h1>=2.01)
		vcat(0:Δx4:2,2.1:0.1:h1) 
	else
		0:Δx4:h1
	end
	title1 = (side1==:lft) ? "x approacheds 1 (from left)" : "x approacheds 1 (from right)"
	tbody1 = if side1==:lft 
		map(x5) do i
		"<tr><td> $(-3+i) </td><td> $(f4(-3+i)) </td></tr>"
		end
	else
		map(x5) do i
		"<tr><td> $(5-i) </td><td> $(f4(5-i)) </td></tr>"
	end
	end
cm"""
<div style="display:flex">
<div>

$(p2_2_2_1)

</div>
<table>
<thead>
<th style="padding-right:30px;">

$(title1)

</th>
<th> 

``f(x)`` approaches 
</th>
</thead>
<tbody>

$(tbody1)

</tbody>
</table>
</div>

"""
end

# ╔═╡ 8eb614cd-0608-4fd0-bfa8-3b5d895fef6b
begin
	whatever(x)=x/(sqrt(x+1)-1)
	whatever(-0.000001)
end

# ╔═╡ 6c066ffe-0c0c-4049-b19f-8cfe75df9c54
md" ## Limits That Fail to Exist "

# ╔═╡ c6fa66ae-159a-4ce8-ae0a-857dd200c5d5
begin
	f5(x)=1/x^2
	f5(-0.00001)
	# plot(x->1/x^2)
end


# ╔═╡ c8994719-b991-4ebe-8980-9fc84699bfe2
plot(x->sin(1/x))

# ╔═╡ 97de049c-b98b-4513-b0b7-9079cc1d2080
md"## A Formal Definition of Limit (Redaing Only)"

# ╔═╡ 42d15a52-e927-40a6-a8bf-52b6526a4ec2
begin
	n5Slider = @bind n5slider  Slider(0:0.01:2,default=0.92,show_value=true)
	epsSlider = @bind epsslider  Slider(0:0.01:1,show_value=true, default=1)
	
	md"""
	
	----
	
	|||
	|---|---|
	|``\epsilon`` =$epsSlider |	``\delta`` = $n5Slider |
	
	----
	"""
end

# ╔═╡ e1f952b0-a407-4f46-87a8-2b3aab9ba875
begin
	sec22def_f(x)=x^2+x+1
	d5=1:1
	L=3
	plt5 = scatter(d5, sec22def_f.(d5),
		frame_style=:origin, 
		ylimits=(-1,6),
		xlimits=(-3,3),
		label=L"f(x)=\frac{x^3-1}{x-1}",
		legend=:topleft,
		title_location=:left,
		title="Example 1 (Graph)"
	)
	annotate!(plt5,
		[
# 		 (50,0.5,
# L"a_{%$n5slider}=\frac{%$n5slider}{%$(1+n5slider)}=%$(round(sec22def_f(n5slider),digits=6))"
# 		 )
		# ,
		(1,L+epsslider+0.1, L"L+\epsilon")  	
		,(1,L-epsslider-0.1, L"L-\epsilon")  	
		,(0.2,L-0.2, L"L")  	
		]
	)
	plot!(plt5,
		[x->L,x->L-epsslider,x->L+epsslider,x->sec22def_f(x)],
		labels=:none
	)
	scatter!(plt5,
		(1,L),
		labels=:none,
		c=:white
	)
	plot!(plt5,
		[(1-n5slider,0),(1-n5slider,10)],
		labels=:none,
		c=:red
	)

	plot!(plt5,
		[(1+n5slider,0),(1+n5slider,10)],
		labels=:none,
		c=:red
	)
	md"""
	$plt5
	"""	
end

# ╔═╡ 1faabe9b-24c1-4348-aff4-88749c9515b9
md"""
# 2.3: Evaluating Limits Analytically
__Objectives__
> - Evaluate a limit using properties of limits.
> - Develop and use a strategy for finding limits.
> - Evaluate a limit using the dividing out technique.
> - Evaluate a limit using the rationalizing technique.
> - Evaluate a limit using the Squeeze Theorem.
"""

# ╔═╡ 1c028ab8-4a04-435f-a2a7-2cbc91fac0c7
md"""
## Properties of Limits
"""

# ╔═╡ dd589ce1-be9a-47b0-96f9-edbf9b355b87
# $(Resource("https://www.dropbox.com/s/bjk5ljmiw9bc6h7/qrcode_itempool.com.png?raw=1",:width=>300))
cm"""
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 27352238-75e3-46b9-848d-e9a9a162b4e6
md"## A Strategy for Finding Limits"

# ╔═╡ 12877031-4740-4e83-9d84-caa3f1073b56
md"## Dividing Out Technique"

# ╔═╡ 035925ba-68dc-48c3-9fcd-3943716e51d2
md"## Rationalizing Technique"

# ╔═╡ 1f1b95e1-b4e7-423e-bad6-5f4ce16d59e0
md"## The Squeeze Theorem"

# ╔═╡ 3ff34afe-801b-4dff-99bc-70db8644d9d9
cm"""
__Exercises__ 
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 111c6a46-66b7-4991-a287-a2f3d6823282
md"""
# 2.5: Infinite Limits
__Objectives__
> - Determine infinite limits from the left and from the right.
> - Find and sketch the vertical asymptotes of the graph of a function.
"""

# ╔═╡ 14cda6a9-9402-44b4-8fc4-87fbff8f4299
plot(1:0.01:1.99,x->3/(x-2),label=nothing,c=:blue);plot!(2.01:0.01:3,x->3/(x-2),label=nothing,c=:blue)

# ╔═╡ 18b05254-7fe8-4193-af46-0e56d21be797
md"""
## Vertical Asymptotes
"""

# ╔═╡ b3332ea6-9812-4d80-9f7e-297e56e25a1e
plot(x->3/(x-2))

# ╔═╡ 955d5f4c-9b3e-481a-b979-061961fdbdf4
cm"""
__Remark__

There are good online graphing tools that you use
- [desmos.com](https://www.desmos.com/calculator)
- [geogebra.org](https://www.geogebra.org/calculator)
"""

# ╔═╡ 36119c48-81ae-4165-a91a-4ea159d7ba87
cm"""
__Exercises__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 80116b16-5a3e-4982-9ac5-dc78c6df60db
md"""# 4.5: Limits at Infinity
__Objectives__
> - Determine (finite) limits at infinity.
> - Determine the horizontal asymptotes, if any, of the graph of a function.
> - Determine infinite limits at infinity.
"""

# ╔═╡ c5775c03-132a-4671-9d32-0abd66e0f058
cm"""
Consider 
```math
f(x) = \frac{3x^2}{x^2+1}
```
"""

# ╔═╡ 076f6153-52f7-4a02-a756-e531c1c134c3
begin
	sec45f1(x)=(3x^2)/(x^2+1)
	sec45X1 = @bind sec45x1 NumberField(-100:1:100,default=0)
	cm"""
	``x = `` $(sec45X1)
	"""
end

# ╔═╡ 5f6b39cb-9708-47fe-a038-150f166e17ce
begin
	sec45p1 = plot(x->sec45f1(x),
		xlimits=(-10,10),ylimits=(-1,4),frame_style=:origin,
		label=nothing
	)
	scatter!(sec45p1,(sec45x1,sec45f1(sec45x1)),label=nothing)
	cm"""
``f(x) = `` $(sec45f1(sec45x1))

$(sec45p1)
	"""
end

# ╔═╡ 0605339e-2b17-4088-aa2f-a75863354a6d
cm"""
we write
```math
\lim_{x\to \infty} \frac{3x^2}{x^2+1} = 3, \quad \lim_{x\to -\infty} \frac{3x^2}{x^2+1} = 3
```
"""

# ╔═╡ cc70d313-74e3-4316-b83b-f1aef828fead
md"## Horizontal Asymptotes"

# ╔═╡ 8c0e4e4b-eea3-4493-94c5-c932ad35c033


# ╔═╡ eb67c3a6-38fe-4cd5-98fd-37028d40c136
# begin 
# 	xx=symbols("xx",real=true)
# 	limit(xx*sin(1/xx),xx,0)
# end

# ╔═╡ 90a75f2b-f1a3-4cd4-82ff-fbbd28d85e46
begin
	n,i = symbols("n,i", integer=true)
	function beginBlock(title,subtitle)
		"""<div style="box-sizing: border-box;">
		<div style="display: flex;flex-direction: column;border: 6px solid rgba(200,200,200,0.5);box-sizing: border-box;">
		<div style="display: flex;">
		<div style="background-color: #FF9733;
		    border-left: 10px solid #df7300;
		    padding: 5px 10px;
		    color: #fff!important;
		    clear: left;
		    margin-left: 0;font-size: 112%;
		    line-height: 1.3;
		    font-weight: 600;">$title</div>  <div style="olor: #000!important;
		    margin: 0 0 20px 25px;
		    float: none;
		    clear: none;
		    padding: 5px 0 0 0;
		    margin: 0 0 0 20px;
		    background-color: transparent;
		    border: 0;
		    overflow: hidden;
		    min-width: 100px;font-weight: 600;
		    line-height: 1.5;">$subtitle</div>
		</div>
		<p style="padding:5px;">
	"""
	end
	function beginTheorem(subtitle)
		beginBlock("Theorem",subtitle)
	end
	function endBlock()
		"""</p></div></div>"""
	end
	function endTheorem()
		 endBlock()
	end
	function example(lable,desc)
		"""<div style="display:flex;">
	<div style="
	font-size: 112%;
	    line-height: 1.3;
	    font-weight: 600;
	    color: #f9ce4e;
	    float: left;
	    background-color: #5c5c5c;
	    border-left: 10px solid #474546;
	    padding: 5px 10px;
	    margin: 0 12px 20px 0;
	    border-radius: 0;
	">$lable:</div>
	<div style="flex-grow:3;
	line-height: 1.3;
	    font-weight: 600;
	    float: left;
	    padding: 5px 10px;
	    margin: 0 12px 20px 0;
	    border-radius: 0;
	">$desc</div>
	</div>"""
	end
	""
end

# ╔═╡ 8f7d8928-edad-4907-b0f9-c7ed745e12ac
begin
	sec21block1 = beginBlock("","")
cm"""


$sec21block1

__Precalculus Matematics__ ``\Rightarrow`` __Limit process__ ``\Rightarrow`` __*Calculus*__

$(endBlock())
"""
end

# ╔═╡ b2f257fc-c50d-44bd-9c95-df51f14a2baf
cm"""
$(beginBlock("Remark",""))

```math
\lim_{x\to 1} \frac{x^3-1}{x-1} = 3
```

$(endBlock())
"""

# ╔═╡ af4405d3-ce2a-4bb1-a010-a501128a435b
begin
	
	e2_2_2_1 = example("Example 1", "Estimating a Limit Numerically")
	p2_2_2_2 = plot(x->x/(sqrt(x+1)-1),frame_style=:origin)
	cm"""
	
	$(e2_2_2_1)
	Evaluate the function ``\displaystyle f(x) = \frac{x}{\sqrt{x+1}\;-1}`` at several ``x``-values near ``0`` and use the results to estimate the limit
	```math
	\lim_{x\to 0} \frac{x}{\sqrt{x+1}\;-1}
	```
	__Graph__
	
	$(p2_2_2_2)
	
	"""
end

# ╔═╡ 730cac84-ac73-4d92-9505-4a6ced92f67d
cm"""
$(example("Example 2", "Finding a Limit"))
Find the limit of ``f(x)`` as ``x`` approaches ``2``, where

```math
f(x) = \begin{cases} 1, \quad x\not=2,\\ 0, \quad x=2 \end{cases}
```
"""

# ╔═╡ a94a331d-b1a1-429b-81e5-576c47a02cfe
cm"""
$(beginBlock("Remark","Problem solving"))
1. Numerical values (using table of values)
2. Graphical  (drawing a graph by hand or by technology: `MATLAB`, `python`, `Julia`)
3. Analytical (using algebra or of course __calculus__)
"""

# ╔═╡ 6f7f81b4-09da-424b-be08-3bf3d3599853
cm"""
$(example("Example 3", "Different Right and Left Behavior"))
Show that the limit ``\displaystyle \lim_{x\to 0}\frac{|x|}{x}`` does not exist.

$(example("Example 4", "Unbounded Behavior"))
Discuss the existence of the limit ``\displaystyle \lim_{x\to 0}\frac{1}{x^2}``
$(example("Example 5", "Oscillating Behavior"))
Discuss the existence of the limit ``\displaystyle \lim_{x\to 0}\sin \left(\frac{1}{x}\right)``
"""

# ╔═╡ 8807bd29-52ef-4dfa-9be7-6ddad30c0874
cm"""
$(beginBlock("Definition of Limit",""))

Let ``f`` be a function defined on an open interval containing ``c`` (except possibly at ``c``), and let __``L``__ be a real number. The statement
```math
\lim_{x\to c}f(x) =L
```
means that for each ``\epsilon>0`` there exists a ``\delta>0`` such that if
```math
0<|x-c|<\delta
```
then
```math
|f(x)-L|<\epsilon
```
$(endBlock())

$(beginBlock("Remark",""))
Throughout this text, the expression
```math
\lim_{x\to c}f(x) =L
```
implies two statements—the limit exists and the limit is ``L``.
$(endBlock())
"""

# ╔═╡ 6b705fc1-7369-430d-90ae-21ffb55ef130
cm"""
$(example("Example",""))
Prove that 
```math
\lim_{x\to 1}\frac{x^3-1}{x-1} = 3
```

"""

# ╔═╡ 0a35eda5-4c45-4bbe-87ac-c5c93456f5d7
cm"""
$(beginTheorem("Some Bacic Limits"))
Let ``b`` and ``c`` be real numbers, and let ``n`` be a positive integer.
1. ``\displaystyle \lim_{x\to c}b = b``

1. ``\displaystyle \lim_{x\to c}x = c``

1. ``\displaystyle \lim_{x\to c}x^n = c^n``

"""

# ╔═╡ 499a6826-524d-436f-85c6-e2b0861a7665
cm"""
$(beginTheorem("Properties of Limits"))
Let ``b`` and ``c`` be real numbers, and let ``n`` be a positive integer, and let ``f`` and ``g`` be functions with the limits
```math
\lim_{x\to c}f(x) = L, \quad \text{and}\quad \lim_{x\to c}g(x) = K
```
1. __Scalar multiple__ ``\displaystyle \lim_{x\to c}\big[bf(x)\big] = bL``

1. __Sum or difference__ ``\displaystyle \lim_{x\to c}\big[f(x)\pm g(x)\big] = L\pm K ``

1. __Product__ ``\displaystyle \lim_{x\to c}\big[f(x)g(x)\big] = LK ``

1. __Quotient__ ``\displaystyle \lim_{x\to c}\left[\frac{f(x)}{g(x)}\right] = \frac{L}{K}, \quad K\ne 0 ``

1. __Power__ ``\displaystyle \lim_{x\to c}\big[f(x)\big]^n = L^n ``


"""

# ╔═╡ 76e41a4d-f9b0-40d9-bfb4-0c1d1a67ec0b
cm"""
$(example("Example 2","The Limit of a Polynomial"))
Find ``\displaystyle \lim_{x\to 2}(4x^2+3)``.
"""

# ╔═╡ 9ec1fcd2-eb58-4043-bb08-6bcd3276dfdf
cm"""
$(beginTheorem("Limits of Polynomial and Rational Functions"))
If ``p`` is a polynomial function and ``c`` is a real number, then
```math
\lim_{x\to c} p(x) = p(c).
```
If ``r`` is a rational function given by ``\displaystyle r(x)=\frac{p(x)}{q(x)}`` and  ``c`` is a real number such that ``q(c)\ne 0``, then

```math
\lim_{x\to c} r(x) = r(c)=\frac{p(c)}{q(c)}.
```

$(endTheorem())
"""

# ╔═╡ 72108166-3372-4876-9765-f69794e30636
cm"""
$(example("Example 3","The Limit of a Rational Function"))
Find
```math
\lim_{x\to 1} \frac{x^2+x+2}{x+1}.
```
"""

# ╔═╡ 0ad3be78-7d26-4fb1-a8ca-bda2e187eb9e
cm"""
$(beginTheorem("The Limit of a Function Involving a Radical"))
Let ``n`` be a positive integer. The limit below is valid for all ``c`` when ``n`` is __odd__, and is valid for ``c>0`` when ``n`` is __even__.
```math
\lim_{x\to c}\sqrt[n]{x} = \sqrt[n]{c}
```
$(endTheorem())
"""

# ╔═╡ 7b1dbf53-5e81-479f-a02f-7c1d3bdab044
cm"""
$(beginTheorem("The Limit of a Composite Function"))
If ``f`` and ``g`` are functions such that  ``\displaystyle \lim_{x\to c}g(x)=L`` 
 and ``\displaystyle \lim_{x\to c}f(x)=f(L)`` , then

```math
\lim_{x\to c}f(g(x)) =f\left(\lim_{x\to c}g(x) \right) = f(L).
```
$(endTheorem())
"""

# ╔═╡ f26b41a6-8d47-4054-a581-b0d6551d4555
cm"""
$(beginTheorem("Limits of Transcendental Functions"))
Let ``c`` be a real number in the domain of the given transcendental function.
1. ``\displaystyle \lim_{x\to c}\sin(x)=\sin(c)``

1. ``\displaystyle \lim_{x\to c}\cos(x)=\cos(c)``

1. ``\displaystyle \lim_{x\to c}\tan(x)=\tan(c)``

1. ``\displaystyle \lim_{x\to c}\cot(x)=\cot(c)``

1. ``\displaystyle \lim_{x\to c}\sec(x)=\sec(c)``

1. ``\displaystyle \lim_{x\to c}\csc(x)=\csc(c)``

1. ``\displaystyle \lim_{x\to c}a^x=a^c, \quad a>0``

1. ``\displaystyle \lim_{x\to c}\ln(x)=\ln(c)``

$(endTheorem())
"""

# ╔═╡ 697049c8-fb88-4a4e-8321-3d3a393a8a9f
cm"""
$(beginTheorem("Functions That Agree at All but One Point"))

Let ``c`` be a real number, and let ``f(x)=g(x)`` for all ``x\ne c`` in an open interval containing ``c``. If the limit of ``g(x)`` as ``x`` approaches ``c`` exists, then the limit of ``f(x)`` also exists and
```math
\lim_{x\to c}f(x)=\lim_{x\to c}g(x).
```


"""

# ╔═╡ b84509ce-2652-4992-86a5-38feb16e5740
cm"""
$(beginBlock("Remarks","A Strategy for Finding Limits"))
1. Learn to recognize which limits can be evaluated by direct substitution. 
2. When the limit of ``f(x)`` as ``x`` approaches ``c`` cannot be evaluated by direct substitution, try to find a function ``g(x)`` that agrees with ``f`` for all  other ``x`` than ``c``.
"""

# ╔═╡ 2e181008-4c07-4892-a03a-06668deb028d
cm"""
$(example("Example 7", "Dividing Out Technique"))
Find the limit ``\displaystyle \lim_{x\to -3}\frac{x^2+x-6}{x+3}``.

"""

# ╔═╡ 528689c1-bdf4-445f-8752-8e9ea9eaf13f
cm"""
__Recall__ 
- __rationalizing__ the numerator (denominator) means __multiplying__ the numerator and denominator by __the conjugate__ of the numerator (denominator)

$(example("Example 8", "Rationalizing Technique"))
Find the limit ``\displaystyle \lim_{x\to 0}\frac{\sqrt{x+1}-1}{x}``.
"""

# ╔═╡ dd3a9ea7-4f3a-4093-94da-bd7fbef4a5b1
cm"""
$(beginTheorem("The Squeeze Theorem"))
if ``h(x)\leq f(x) \leq g(x)`` for all ``x`` in an open interval containing ``c``, except possibly at ``c`` itself, and if
```math
\lim_{x\to c} h(x) = L = \lim_{x\to c} g(x)
```
then ``\displaystyle \lim_{x\to c} f(x)`` __exists__ and equal to __``L``__.


<div class="img-container">

$(Resource("https://www.dropbox.com/s/ffqo5473bphbnj6/sqeeze_theorem.jpg?raw=1",:width=>300))
</div>

$(endTheorem())
"""

# ╔═╡ f15d4738-673c-41ea-8375-070b233047a4
cm"""
$(beginTheorem("Three Special Limits"))
1. ``\displaystyle \lim_{x\to 0}\frac{\sin x}{x}=1``.

1. ``\displaystyle \lim_{x\to 0}\frac{1-\cos x}{x}=0``.

1. ``\displaystyle \lim_{x\to 0}(1+x)^{1/x}=e``.

$(endTheorem())
"""

# ╔═╡ bb1a5fb6-1f86-4da3-8435-4c3f004c7aa9
cm"""
$(example("Example 9","A Limit Involving a Trigonometric Function"))

Find the limit: ``\displaystyle \lim_{x\to 0}\frac{\tan x}{x}``.

$(example("Example 10","A Limit Involving a Trigonometric Function"))

Find the limit: ``\displaystyle \lim_{x\to 0}\frac{\sin 4 x}{x}``.
"""

# ╔═╡ 9824d5c5-0a66-410c-922a-4deaa4914382
begin
cm"""
$(example("Example", "Infinite Limit"))
Consider
```math
f(x)=\frac{3}{x-2}
"""
end

# ╔═╡ e323e17b-5762-4f4d-9669-ca10536bdee9
cm"""
$(beginBlock("Definition of Vertical Asymptote",""))
If ``f(x)``  approaches infinity (or negative infinity) as ``x`` approaches ``c`` from the right or the left, then the line __``x=c``__ is a __vertical asymptote__ of the graph of .

$(endBlock())

__Remark__

If the graph of a function ``f`` has a vertical asymptote at ``x=c``, then ``f`` is not continuous at ``c``.
"""

# ╔═╡ caa271b0-f0ae-4d37-92b2-ce8669f35aaf
cm"""
$(beginTheorem("Vertical Asymptotes"))

Let ``f`` and ``g`` be continuous on an open interval containing __``c``__. If ``f(c)\ne 0``, ``g(c)= 0``, and there exists an open interval containing ``c`` such that ``g(x)\ne 0`` for all ``x\ne c``  in the interval, then the graph of the function
```math
h(x)=\frac{f(x)}{g(x)}
```
has a vertical asymptote at ``c``.
$(endTheorem())

"""

# ╔═╡ ed191e82-b314-43eb-85ec-3d2ddd177e60
cm"""
$(example("Example 2","Finding Vertical Asymptotes"))

1. ``\displaystyle h(x)=\frac{1}{2(x+1)}``.
---
2. ``\displaystyle h(x)=\frac{x^2+1}{x^2-1}``.
---
3. ``\displaystyle h(x)=\cot x=\frac{\cos x}{\sin x}``.

"""

# ╔═╡ 6b301595-b3ca-4af7-8813-8fedbab8330b
cm"""
$(example("Example 3","A Rational Function with Common Factors"))
Determine all vertical asymptotes of the graph of
```math
h(x)=\frac{x^2+2x-8}{x^2-4}.
```
"""

# ╔═╡ 3ede9245-1716-4357-80e5-acf7a1dcffd6
cm"""
$(example("Example 4","Determining Infinite Limits"))
Find each limit.
```math
\lim_{x\to 1^{-}}\frac{x^3-3x}{x-1}\qquad\text{and}\qquad \lim_{x\to 1^{+}}\frac{x^3-3x}{x-1}
```
"""

# ╔═╡ 3f9f7ef1-8a43-4095-8a28-be26b56eb40c
cm"""
$(beginTheorem("Properties of Infinite Limits"))

Let ``c`` and ``L`` be real numbers, and let ``f`` and ``g`` be functions such that
```math
\lim_{x\to c}f(x) =\infty \quad\text{and}\quad \lim_{x\to c}g(x) =L
```
1.	__Sum or difference__: 	``\displaystyle \lim_{x\to c}\big[f(x)\pm g(x)\big]	=\infty``
2.	__Product__:	
```math 
\displaystyle 
\begin{array}{l}
\lim_{x\to c}\big[f(x)g(x)\big]	=\infty, \quad L>0\\
\lim_{x\to c}\big[f(x)g(x)\big]	=-\infty, \quad L<0
\end{array}
```
3.	Quotient:	
``\displaystyle 
\lim_{x\to c}\left[\frac{g(x)}{f(x)}\right]	=0\\``


$(beginBlock("Remark",""))
2. is __not true__ if ``\displaystyle \lim_{x\to c}g(x)=0``
$(endBlock())
$(endTheorem())
"""

# ╔═╡ 5e4eb8a8-b5b4-4fd6-b98c-319b46293ef9
begin
	function reimannSum(f, n, a, b; method="l", color=:green, plot_it=false)
    Δx = (b - a) / n
    x = a:0.1:b
    # plot(f;xlim=(-2π,2π), xticks=(-2π:(π/2):2π,["$c π" for c in -2:0.5:2]))

    (partition, recs) = if method == "r"
        parts = (a+Δx):Δx:b
        rcs = [rect(p - Δx, Δx, p, f) for p in parts]
        (parts, rcs)
    elseif method == "m"
        parts = (a+(Δx/2)):Δx:(b-(Δx/2))
        rcs = [rect(p - Δx / 2, Δx, p, f) for p in parts]
        (parts, rcs)
    elseif method == "l"
        parts = a:Δx:(b-Δx)
        rcs = [rect(p, Δx, p, f) for p in parts]
        (parts, rcs)
    else
        parts = a:Δx:(b-Δx)
        rcs = [rect(p, Δx, rand(p:0.1:p+Δx), f) for p in parts]
        (parts, rcs)
    end
    # recs= [rect(sample(p,Δx),Δx,p,f) for p in partition]
    p = plot(x, f.(x); legend=nothing)
    plot!(p, recs, framestyle=:origin, opacity=0.4, color=color)
    s = round(sum(f.(partition) * Δx), sigdigits=6)
    return plot_it ? (p, s) : s
	end
	rect(x, Δx, xs, f) = Shape([(x, 0), (x + Δx, 0), (x + Δx, f(xs)), (x, f(xs))])
	""
end

# ╔═╡ 2a08359c-3996-42ee-8ff5-f87b735c8ba4
begin
	theme(:wong)
    anchor1 = 0.5
    (p, s) = reimannSum(f3, n1, a1, b1; method=lr, plot_it=true)

    annotate!(p, [(anchor1, f3(anchor1) - 2, text(L"$\sum_{i=1}^{%$n} f (x_{i})\Delta x=%$s$", 12, n > 500 ? :white : :black))])
    annotate!(p3, [(anchor1 + 0.5, f3(anchor1 + 0.1), text(L"$y=f(x)", 12, :black))])

    md""" 	

    $p
    """
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Colors = "5ae59095-9a9b-59fe-a467-6f913c188581"
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19"
ImageShow = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
ImageTransformations = "02fcd773-0e25-5acc-982a-7f6622650795"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
PGFPlotsX = "8314cec4-20b6-5062-9cdb-752b83310925"
PlotThemes = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[compat]
Colors = "~0.12.10"
CommonMark = "~0.8.12"
FileIO = "~1.16.1"
HypertextLiteral = "~0.9.4"
ImageIO = "~0.6.6"
ImageShow = "~0.3.7"
ImageTransformations = "~0.9.5"
LaTeXStrings = "~1.3.0"
PGFPlotsX = "~1.5.1"
PlotThemes = "~3.1.0"
Plots = "~1.38.15"
PlutoUI = "~0.7.51"
SymPy = "~1.1.8"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "6613d78ff28019ecb8678f90a330ac43d630daf8"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "16b6dbc4cf7caee4e1e75c49485ec67b667098a0"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.3.1"
weakdeps = ["ChainRulesCore"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "76289dc51920fdc6e0013c872ba9551d54961c24"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.6.2"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.ArgCheck]]
git-tree-sha1 = "a3a402a35a2f7e0b87828ccabbd5ebfbebe356b4"
uuid = "dce04be8-c92d-5529-be00-80e4d2c0e197"
version = "2.3.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[deps.AxisArrays]]
deps = ["Dates", "IntervalSets", "IterTools", "RangeArrays"]
git-tree-sha1 = "1dd4d9f5beebac0c03446918741b1a03dc5e5788"
uuid = "39de3d68-74b9-583c-8d2d-e117c070f3a9"
version = "0.4.6"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "eb4cb44a499229b3b8426dcfb5dd85333951ff90"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.2"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e30f2f4e20f7f186dc36529910beaedc60cfa644"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.16.0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "9c209fb7536406834aa938fb149964b985de6c83"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.1"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "be6ab11021cd29f0344d5c4357b163af05a48cba"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.21.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.CommonEq]]
git-tree-sha1 = "d1beba82ceee6dc0fce8cb6b80bf600bbde66381"
uuid = "3709ef60-1bee-4518-9f2f-acd86f176c50"
version = "0.2.0"

[[deps.CommonMark]]
deps = ["Crayons", "JSON", "PrecompileTools", "URIs"]
git-tree-sha1 = "532c4185d3c9037c0237546d817858b23cf9e071"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.12"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "96d823b94ba8d187a6d8f0826e731195a74b90e9"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.0"

[[deps.Conda]]
deps = ["Downloads", "JSON", "VersionParsing"]
git-tree-sha1 = "e32a90da027ca45d84678b826fffd3110bb3fc90"
uuid = "8f4d0f93-b110-5947-807f-2305c1781a2d"
version = "1.8.0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "738fec4d684a9a6ee9598a8bfee305b26831f28c"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.2"
weakdeps = ["IntervalSets", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.CoordinateTransformations]]
deps = ["LinearAlgebra", "StaticArrays"]
git-tree-sha1 = "f9d7112bfff8a19a3a4ea4e03a8e6a91fe8456bf"
uuid = "150eb455-5306-5404-9cee-2592286d6298"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DefaultApplication]]
deps = ["InteractiveUtils"]
git-tree-sha1 = "c0dfa5a35710a193d83f03124356eef3386688fc"
uuid = "3f0dd361-4fe0-5fc6-8523-80b14ec94d85"
version = "1.1.0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "299dc33549f68299137e51e6d49a13b5b1da9673"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.1"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "8b8a2fd4536ece6e554168c21860b6820a8a83db"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "19fad9cd9ae44847fe842558a744748084a722d1"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.7+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphics]]
deps = ["Colors", "LinearAlgebra", "NaNMath"]
git-tree-sha1 = "d61890399bc535850c4bf08e4e0d3a7ad0f21cbd"
uuid = "a2bd30eb-e257-5431-a919-1863eab51364"
version = "1.1.2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e77dbf117412d4f164a464d610ee6050cc75272"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.6"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.ImageAxes]]
deps = ["AxisArrays", "ImageBase", "ImageCore", "Reexport", "SimpleTraits"]
git-tree-sha1 = "c54b581a83008dc7f292e205f4c409ab5caa0f04"
uuid = "2803e5a7-5153-5ecf-9a86-9b4c37f5f5ac"
version = "0.6.10"

[[deps.ImageBase]]
deps = ["ImageCore", "Reexport"]
git-tree-sha1 = "b51bb8cae22c66d0f6357e3bcb6363145ef20835"
uuid = "c817782e-172a-44cc-b673-b171935fbb9e"
version = "0.1.5"

[[deps.ImageCore]]
deps = ["AbstractFFTs", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Graphics", "MappedArrays", "MosaicViews", "OffsetArrays", "PaddedViews", "Reexport"]
git-tree-sha1 = "acf614720ef026d38400b3817614c45882d75500"
uuid = "a09fc81d-aa75-5fe9-8630-4744c3626534"
version = "0.9.4"

[[deps.ImageIO]]
deps = ["FileIO", "IndirectArrays", "JpegTurbo", "LazyModules", "Netpbm", "OpenEXR", "PNGFiles", "QOI", "Sixel", "TiffImages", "UUIDs"]
git-tree-sha1 = "342f789fd041a55166764c351da1710db97ce0e0"
uuid = "82e4d734-157c-48bb-816b-45c225c6df19"
version = "0.6.6"

[[deps.ImageMetadata]]
deps = ["AxisArrays", "ImageAxes", "ImageBase", "ImageCore"]
git-tree-sha1 = "36cbaebed194b292590cba2593da27b34763804a"
uuid = "bc367c6b-8a6b-528e-b4bd-a4b897500b49"
version = "0.9.8"

[[deps.ImageShow]]
deps = ["Base64", "ColorSchemes", "FileIO", "ImageBase", "ImageCore", "OffsetArrays", "StackViews"]
git-tree-sha1 = "ce28c68c900eed3cdbfa418be66ed053e54d4f56"
uuid = "4e3cecfd-b093-5904-9786-8bbb286a6a31"
version = "0.3.7"

[[deps.ImageTransformations]]
deps = ["AxisAlgorithms", "ColorVectorSpace", "CoordinateTransformations", "ImageBase", "ImageCore", "Interpolations", "OffsetArrays", "Rotations", "StaticArrays"]
git-tree-sha1 = "8717482f4a2108c9358e5c3ca903d3a6113badc9"
uuid = "02fcd773-0e25-5acc-982a-7f6622650795"
version = "0.9.5"

[[deps.Imath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3d09a9f60edf77f8a4d99f9e015e8fbf9989605d"
uuid = "905a6f67-0a94-5f89-b386-d35d92009cd1"
version = "3.1.7+0"

[[deps.IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[deps.Inflate]]
git-tree-sha1 = "5cd07aab533df5170988219191dfad0519391428"
uuid = "d25df0c9-e2be-5dd7-82c8-3ad0b3e990b9"
version = "0.1.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Interpolations]]
deps = ["Adapt", "AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "721ec2cf720536ad005cb38f50dbba7b02419a15"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.14.7"

[[deps.IntervalSets]]
deps = ["Dates", "Random", "Statistics"]
git-tree-sha1 = "16c0cc91853084cb5f58a78bd209513900206ce6"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.4"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "4ced6667f9974fc5c5943fa5e2ef1ca43ea9e450"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.8.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo]]
deps = ["CEnum", "FileIO", "ImageCore", "JpegTurbo_jll", "TOML"]
git-tree-sha1 = "106b6aa272f294ba47e96bd3acbabdc0407b5c60"
uuid = "b835a17e-a41a-41e7-81f0-2f016b05efe0"
version = "0.1.2"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "8c57307b5d9bb3be1ff2da469063628631d4d51e"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.21"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    DiffEqBiologicalExt = "DiffEqBiological"
    ParameterizedFunctionsExt = "DiffEqBase"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    DiffEqBase = "2b5f629d-d688-5b77-993f-72d75c75574e"
    DiffEqBiological = "eb300fae-53e8-50a0-950c-e21f52c2b7e0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LazyModules]]
git-tree-sha1 = "a560dd966b386ac9ae60bdd3a3d3a326062d3c3e"
uuid = "8cdb02fc-e678-4876-92c5-9defec4f444e"
version = "0.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "c3ce8e7420b3a6e071e0fe4745f5d4300e37b13f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.24"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.MappedArrays]]
git-tree-sha1 = "2dab0221fe2b0f2cb6754eaa743cc266339f527e"
uuid = "dbb5928d-eab1-5f90-85c2-b9b0edb7c900"
version = "0.4.2"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MosaicViews]]
deps = ["MappedArrays", "OffsetArrays", "PaddedViews", "StackViews"]
git-tree-sha1 = "7b86a5d4d70a9f5cdf2dacb3cbe6d251d1a61dbe"
uuid = "e94cdb99-869f-56ef-bcf0-1ae2bcbe0389"
version = "0.3.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.Netpbm]]
deps = ["FileIO", "ImageCore", "ImageMetadata"]
git-tree-sha1 = "5ae7ca23e13855b3aba94550f26146c01d259267"
uuid = "f09324ee-3d7c-5217-9330-fc30815ba969"
version = "1.1.0"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "82d7c9e310fe55aa54996e6f7f94674e2a38fcb4"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.9"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenEXR]]
deps = ["Colors", "FileIO", "OpenEXR_jll"]
git-tree-sha1 = "327f53360fdb54df7ecd01e96ef1983536d1e633"
uuid = "52e1d378-f018-4a11-a4be-720524705ac7"
version = "0.3.2"

[[deps.OpenEXR_jll]]
deps = ["Artifacts", "Imath_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "a4ca623df1ae99d09bc9868b008262d0c0ac1e4f"
uuid = "18a262bb-aa17-5467-a713-aee519bc75cb"
version = "3.1.4+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1aa4b74f80b01c6bc2b89992b861b5f210e665b5"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.21+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+0"

[[deps.PGFPlotsX]]
deps = ["ArgCheck", "DataStructures", "Dates", "DefaultApplication", "DocStringExtensions", "MacroTools", "Parameters", "Requires", "Tables"]
git-tree-sha1 = "1d3729f2cd114a8150ce134f697d07f9ef2b9657"
uuid = "8314cec4-20b6-5062-9cdb-752b83310925"
version = "1.5.1"

[[deps.PNGFiles]]
deps = ["Base64", "CEnum", "ImageCore", "IndirectArrays", "OffsetArrays", "libpng_jll"]
git-tree-sha1 = "f809158b27eba0c18c269cf2a2be6ed751d3e81d"
uuid = "f57f5aa1-a3ce-4bc8-8ab9-96f992907883"
version = "0.3.17"

[[deps.PaddedViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "0fac6313486baae819364c52b4f483450a9d793f"
uuid = "5432bcbf-9aad-5242-b902-cca2824c8663"
version = "0.5.12"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.PkgVersion]]
deps = ["Pkg"]
git-tree-sha1 = "f6cf8e7944e50901594838951729a1861e668cb8"
uuid = "eebad327-c553-4316-9ea0-9fa01ccd7688"
version = "0.3.2"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "ceb1ec8d4fbeb02f8817004837d924583707951b"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.15"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "b478a748be27bd2f2c73a7690da219d0844db305"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.51"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "9673d39decc5feece56ef3940e5dafba15ba0f81"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.ProgressMeter]]
deps = ["Distributed", "Printf"]
git-tree-sha1 = "d7a7aef8f8f2d537104f170139553b14dfe39fe9"
uuid = "92933f4c-e287-5a05-a399-4b506db050ca"
version = "1.7.2"

[[deps.PyCall]]
deps = ["Conda", "Dates", "Libdl", "LinearAlgebra", "MacroTools", "Serialization", "VersionParsing"]
git-tree-sha1 = "62f417f6ad727987c755549e9cd88c46578da562"
uuid = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
version = "1.95.1"

[[deps.QOI]]
deps = ["ColorTypes", "FileIO", "FixedPointNumbers"]
git-tree-sha1 = "18e8f4d1426e965c7b532ddd260599e1510d26ce"
uuid = "4b34888f-f399-49d4-9bb3-47ed5cae4e65"
version = "1.0.0"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.Quaternions]]
deps = ["LinearAlgebra", "Random", "RealDot"]
git-tree-sha1 = "da095158bdc8eaccb7890f9884048555ab771019"
uuid = "94ee1d12-ae83-5a48-8b1c-48b8ff168ae0"
version = "0.7.4"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RangeArrays]]
git-tree-sha1 = "b9039e93773ddcfc828f12aadf7115b4b4d225f5"
uuid = "b3c3ace0-ae52-54e7-9d0b-2c1406fd6b9d"
version = "0.3.2"

[[deps.Ratios]]
deps = ["Requires"]
git-tree-sha1 = "1342a47bf3260ee108163042310d26f2be5ec90b"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.5"
weakdeps = ["FixedPointNumbers"]

    [deps.Ratios.extensions]
    RatiosFixedPointNumbersExt = "FixedPointNumbers"

[[deps.RealDot]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9f0a1b71baaf7650f4fa8a1d168c7fb6ee41f0c9"
uuid = "c1ae055f-0cd5-4b69-90a6-9a35b1a98df9"
version = "0.1.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Rotations]]
deps = ["LinearAlgebra", "Quaternions", "Random", "StaticArrays"]
git-tree-sha1 = "54ccb4dbab4b1f69beb255a2c0ca5f65a9c82f08"
uuid = "6038ab10-8711-5258-84ad-4b1120ba62dc"
version = "1.5.1"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SimpleTraits]]
deps = ["InteractiveUtils", "MacroTools"]
git-tree-sha1 = "5d7e3f4e11935503d3ecaf7186eac40602e7d231"
uuid = "699a6c99-e7fa-54fc-8d76-47d257e15c1d"
version = "0.9.4"

[[deps.Sixel]]
deps = ["Dates", "FileIO", "ImageCore", "IndirectArrays", "OffsetArrays", "REPL", "libsixel_jll"]
git-tree-sha1 = "8fb59825be681d451c246a795117f317ecbcaa28"
uuid = "45858cf5-a6b0-47a3-bbea-62219f50df47"
version = "0.1.2"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StackViews]]
deps = ["OffsetArrays"]
git-tree-sha1 = "46e589465204cd0c08b4bd97385e4fa79a0c770c"
uuid = "cae243ae-269e-4f55-b966-ac2d0dc13c15"
version = "0.1.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "StaticArraysCore", "Statistics"]
git-tree-sha1 = "8982b3607a212b070a5e46eea83eb62b4744ae12"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.5.25"

[[deps.StaticArraysCore]]
git-tree-sha1 = "6b7ba252635a5eff6a0b0664a41ee140a1c9e72a"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "75ebe04c5bed70b91614d684259b661c9e6274a4"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.SymPy]]
deps = ["CommonEq", "CommonSolve", "Latexify", "LinearAlgebra", "Markdown", "PyCall", "RecipesBase", "SpecialFunctions"]
git-tree-sha1 = "fcb24df16e451cfa8e1e1217edfd92054f75d49d"
uuid = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
version = "1.1.8"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "1544b926975372da01227b382066ab70e574a3ec"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TiffImages]]
deps = ["ColorTypes", "DataStructures", "DocStringExtensions", "FileIO", "FixedPointNumbers", "IndirectArrays", "Inflate", "Mmap", "OffsetArrays", "PkgVersion", "ProgressMeter", "UUIDs"]
git-tree-sha1 = "8621f5c499a8aa4aa970b1ae381aae0ef1576966"
uuid = "731e570b-9d59-4bfa-96dc-6df516fadf69"
version = "0.6.4"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "ba4aa36b2d5c98d6ed1f149da916b3ba46527b2b"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.14.0"

    [deps.Unitful.extensions]
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.VersionParsing]]
git-tree-sha1 = "58d6e80b4ee071f5efd07fda82cb9fbe17200868"
uuid = "81def892-9a0e-5fdd-b105-ffc91e053289"
version = "1.3.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.7.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libsixel_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "libpng_jll"]
git-tree-sha1 = "d4f63314c8aa1e48cd22aa0c17ed76cd1ae48c3c"
uuid = "075b6546-f08a-558a-be8f-8157d0f608a5"
version = "1.10.3+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─eb5cb250-0691-11ee-0fa7-63ff4496bc57
# ╟─9e13821e-02da-44ca-a89f-d767a1b20fdd
# ╟─fc618c32-0288-4ac8-a372-067abfca73d1
# ╟─8d6ed1ef-7e76-4b53-a366-f06c67987ec2
# ╟─31a33b85-4cf2-4263-a2a8-9e3f492e73de
# ╟─7cf53b88-c492-41a4-98b1-1b96f2605e6c
# ╟─d69e90f6-43fe-4bc4-b22b-7b799b492905
# ╟─8f7d8928-edad-4907-b0f9-c7ed745e12ac
# ╟─dd289ebf-aa4d-4436-8690-5a93cbad046f
# ╟─af42a2d7-b304-4845-817a-c98fa1f8964b
# ╟─172631df-e61d-4c04-9135-66ea58c07786
# ╟─5b818cd4-3930-443f-acd4-96a1dd09084d
# ╟─abd33bc9-d00c-4eb2-81fd-b8431ae6288d
# ╟─c9c7c4bd-0de4-4878-a00b-9bce01654e1b
# ╟─8995c3bf-2259-4f68-9ac9-e620a08ce7f3
# ╟─7cf7773b-92b6-466d-b793-c34b46691f79
# ╟─e49b3b27-5fe2-4874-bad2-815aaa5b2ebd
# ╟─0d03b351-8d6c-41b8-a270-8277ed4c280b
# ╟─99374bba-df51-4b6c-976d-2f54c3167367
# ╟─2a08359c-3996-42ee-8ff5-f87b735c8ba4
# ╟─1cc33cad-c78e-4f5c-993c-af477781549f
# ╟─66751f8f-e505-47e2-9db2-4d68653acca0
# ╟─46db1f9c-5944-4647-9ee9-b24065303325
# ╟─c2fa6116-3b80-4843-b3ad-b6e035e341ba
# ╟─9934a07b-29d3-4e1f-abc1-05ddd213d216
# ╟─b2f257fc-c50d-44bd-9c95-df51f14a2baf
# ╟─af4405d3-ce2a-4bb1-a010-a501128a435b
# ╠═8eb614cd-0608-4fd0-bfa8-3b5d895fef6b
# ╟─730cac84-ac73-4d92-9505-4a6ced92f67d
# ╟─a94a331d-b1a1-429b-81e5-576c47a02cfe
# ╟─6c066ffe-0c0c-4049-b19f-8cfe75df9c54
# ╟─6f7f81b4-09da-424b-be08-3bf3d3599853
# ╟─c6fa66ae-159a-4ce8-ae0a-857dd200c5d5
# ╠═c8994719-b991-4ebe-8980-9fc84699bfe2
# ╠═b76f4e8f-6ff0-4a0f-9d5b-a961dfea00d8
# ╟─97de049c-b98b-4513-b0b7-9079cc1d2080
# ╟─8807bd29-52ef-4dfa-9be7-6ddad30c0874
# ╟─6b705fc1-7369-430d-90ae-21ffb55ef130
# ╟─42d15a52-e927-40a6-a8bf-52b6526a4ec2
# ╟─e1f952b0-a407-4f46-87a8-2b3aab9ba875
# ╟─1faabe9b-24c1-4348-aff4-88749c9515b9
# ╟─1c028ab8-4a04-435f-a2a7-2cbc91fac0c7
# ╟─0a35eda5-4c45-4bbe-87ac-c5c93456f5d7
# ╟─499a6826-524d-436f-85c6-e2b0861a7665
# ╟─76e41a4d-f9b0-40d9-bfb4-0c1d1a67ec0b
# ╟─9ec1fcd2-eb58-4043-bb08-6bcd3276dfdf
# ╟─72108166-3372-4876-9765-f69794e30636
# ╟─0ad3be78-7d26-4fb1-a8ca-bda2e187eb9e
# ╟─7b1dbf53-5e81-479f-a02f-7c1d3bdab044
# ╟─f26b41a6-8d47-4054-a581-b0d6551d4555
# ╟─dd589ce1-be9a-47b0-96f9-edbf9b355b87
# ╟─27352238-75e3-46b9-848d-e9a9a162b4e6
# ╟─697049c8-fb88-4a4e-8321-3d3a393a8a9f
# ╟─b84509ce-2652-4992-86a5-38feb16e5740
# ╟─12877031-4740-4e83-9d84-caa3f1073b56
# ╟─2e181008-4c07-4892-a03a-06668deb028d
# ╟─035925ba-68dc-48c3-9fcd-3943716e51d2
# ╟─528689c1-bdf4-445f-8752-8e9ea9eaf13f
# ╟─1f1b95e1-b4e7-423e-bad6-5f4ce16d59e0
# ╟─dd3a9ea7-4f3a-4093-94da-bd7fbef4a5b1
# ╟─f15d4738-673c-41ea-8375-070b233047a4
# ╟─bb1a5fb6-1f86-4da3-8435-4c3f004c7aa9
# ╟─3ff34afe-801b-4dff-99bc-70db8644d9d9
# ╟─111c6a46-66b7-4991-a287-a2f3d6823282
# ╟─9824d5c5-0a66-410c-922a-4deaa4914382
# ╠═14cda6a9-9402-44b4-8fc4-87fbff8f4299
# ╟─18b05254-7fe8-4193-af46-0e56d21be797
# ╟─e323e17b-5762-4f4d-9669-ca10536bdee9
# ╟─caa271b0-f0ae-4d37-92b2-ce8669f35aaf
# ╟─ed191e82-b314-43eb-85ec-3d2ddd177e60
# ╠═b3332ea6-9812-4d80-9f7e-297e56e25a1e
# ╟─955d5f4c-9b3e-481a-b979-061961fdbdf4
# ╟─6b301595-b3ca-4af7-8813-8fedbab8330b
# ╟─3ede9245-1716-4357-80e5-acf7a1dcffd6
# ╟─3f9f7ef1-8a43-4095-8a28-be26b56eb40c
# ╟─36119c48-81ae-4165-a91a-4ea159d7ba87
# ╟─80116b16-5a3e-4982-9ac5-dc78c6df60db
# ╟─c5775c03-132a-4671-9d32-0abd66e0f058
# ╟─076f6153-52f7-4a02-a756-e531c1c134c3
# ╟─5f6b39cb-9708-47fe-a038-150f166e17ce
# ╟─0605339e-2b17-4088-aa2f-a75863354a6d
# ╟─cc70d313-74e3-4316-b83b-f1aef828fead
# ╠═8c0e4e4b-eea3-4493-94c5-c932ad35c033
# ╠═eb67c3a6-38fe-4cd5-98fd-37028d40c136
# ╟─90a75f2b-f1a3-4cd4-82ff-fbbd28d85e46
# ╟─5e4eb8a8-b5b4-4fd6-b98c-319b46293ef9
# ╠═4e4a8aec-cb96-41b1-b5da-c9510e0fe09e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
