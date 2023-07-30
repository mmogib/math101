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

# ╔═╡ fcb34469-c7bc-4e1e-9cda-8ba0bc6cd23a
cm"""
__Examples__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ eb67c3a6-38fe-4cd5-98fd-37028d40c136
# begin 
# 	xx=symbols("xx",real=true)
# 	limit(xx*sin(1/xx),xx,0)
# end

# ╔═╡ ae67e747-c131-40f8-ac4a-736934d6b5b4
md"""
## Infinite Limits at Infinity
"""

# ╔═╡ f9476d3e-3837-42c9-9e11-95097a6b2373
md"""# 2.4: Continuity and One-Sided Limits
__Objectives__
> - Determine continuity at a point and continuity on an open interval.
> - Determine one-sided limits and continuity on a closed interval.
> - Use properties of continuity.
> - Understand and use the Intermediate Value Theorem. 
"""

# ╔═╡ 26a599c7-e877-4f73-a234-c41eff8d8e1c
md"## Continuity at a Point and on an Open Interval"

# ╔═╡ 32275e49-51e9-4aa1-bb01-3bbfea0edd64
cm"""
__The graph of ``f`` is no contnious at ``x=c``__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/0uprtil51n71g25/se4.1_discont_1.png?raw=1"))

</div>
In Figure __above__, it appears that continuity at ``x=c`` can be __destroyed__ by any one of __three conditions__.

1. The function is not defined at ``x=c``.

2. The limit of ``f(x)`` does not exist at ``x=c``.

3. The limit of ``f(x)`` exists at ``x=c``, but it is not equal to ``f(c)``.

"""

# ╔═╡ fb24f85a-0feb-4f51-beb7-caa0910821a0
cm"""
__Examples__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 12b2f6cf-6c12-4d3e-83fe-f6880ac86a80
md"## One-Sided Limits and Continuity on a Closed Interval"

# ╔═╡ e77cda7c-2a23-4e22-9df9-3ec75f35ba1c
cm"""
__(a) Limit from right__ ``\displaystyle \lim_{x\to c^+}f(x)=L``
<div class="img-container">

$(Resource("https://www.dropbox.com/s/jpog0rwqgjcfems/se4.1_left_limit.png?raw=1"))
</div>

__(b) Limit from left__ ``\displaystyle \lim_{x\to c^-}f(x)=L``

"""

# ╔═╡ de60d9c6-36ed-4212-9172-76fc23e0732f
cm"""
__STEP FUNCTIONS__ 

(__greatest integer function__)

```math
[\kern-0.2em[x]\kern-0.2em]=\textbf{ greatest integer } n \textbf{ such that }n\leq x. 
```

<div class="img-container">

$(Resource("https://www.dropbox.com/s/5t0e202aryizwzs/se24_step_function.png?raw=1",:width=>500))
</div>

"""

# ╔═╡ 9ea783cf-173e-4a8a-8be7-dc8c7d03da89
md"## Properties of Continuity"

# ╔═╡ 911f9cdf-f753-4034-adc4-7e598610735a
cm"""
__Exercises__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ afceaec3-6d71-48d0-b456-47fcbd9f4b85
md"## The Intermediate Value Theorem"

# ╔═╡ 161c840c-8309-41ee-b41c-4f5f7d622762
md"""
# 3.1: The Derivative and the Tangent Line Problem
__Objectives__
> - Find the slope of the tangent line to a curve at a point.
> - Use the limit definition to find the derivative of a function.
> - Understand the relationship between differentiability and continuity.
"""

# ╔═╡ 9306823c-46fa-40a6-bdc8-2b60669040a6
md"## The Tangent Line Problem"

# ╔═╡ 866720a0-cd9b-448d-8832-f9fb098e0bfb
begin
	Sec31dxSlider = @bind Sec31Δx1 Slider(0:0.1:4, default=4,show_value=true)
	cm"""
	``\Delta x``  $Sec31dxSlider
	"""
end

# ╔═╡ ef9db5e3-a380-4962-bc2c-765f1bbb3ff3
begin
	Sec31f1(x)=0.2x^2+1
	Sec31df2(x)=0.4x
	Sec31slope1(d) =(Sec31f1(1+d)-Sec31f1(1))/d
	Sec31p2= plot(x->Sec31f1(x),
		aspect_ratio=1,
		xlimits=(-4,6),
		ylimits=(-0.5,8),
		c=:blue,
		linewidth=2,
		xticks=([1,2,3,4,5],["","","","",""]),
		yticks=([1,2,3,4,5,6,7,8],["","","","",""]),
		annotations=[
				(6,0.2,L"x"),
				(0.2,8,L"y"),
				(1,0.2,L"c"),
				(1+Sec31Δx1,-0.2,text(L"c+\Delta x",10)),
				(1+Sec31Δx1,0,text(L"\bullet",10)),
				(4.5,3.5,L"y=f(x)"),
				(1,Sec31f1(1)-0.01,L"\bullet"),
				(0.8,Sec31f1(1)+0.35,text(L"P(c,f(c))",8)),
				(1+Sec31Δx1,Sec31f1(1+Sec31Δx1)-0.35,text(L"Q(c+\Delta x,f(c+\Delta x))",8)),
				(1+Sec31Δx1,Sec31f1(1+Sec31Δx1)-0.01,L"\bullet"),
		],
		frame_style=:origin, 
		label=:none)
	plot!(Sec31p2,x->(Sec31slope1(Sec31Δx1))*(x-1)+Sec31f1(1),c=:green,label=nothing)
	plot!(Sec31p2,x->Sec31df2(1)*(x-1)+f2(1),c=:black,label=nothing)
	txt = if Sec31Δx1==0 
		cm"""
__Slope of tangent line__ 
```math
\text{m}=\lim_{\Delta x\to 0}\frac{\Delta y}{\Delta x}= \lim_{\Delta x\to 0}\frac{f(c+\Delta x)-f(c)}{\Delta x}
```
"""
	else
		cm"""
<span style="color:green;"> __Slope of secant line__ </span>
```math
\color{green}{
\text{m}_{sec}=\frac{f(c+\Delta x)-f(c)}{\Delta x}
}
```
		"""
	end
	cm"""
	__Find the equation of the secant line__
	$Sec31p2
	

	$txt
	"""
end

# ╔═╡ 6c1ebc93-5c8f-46d0-983e-661a15aa7d17
md"## The Derivative of a Function"

# ╔═╡ 858f00d8-0d8d-473a-933a-2fe8eda40239
md"## Differentiability and Continuity"

# ╔═╡ 1bbe720c-deeb-4efd-aed2-65d1660536d3
cm"""
<div class="img-container">

$(Resource("https://www.dropbox.com/s/2xl7s6z048mg3lo/sec3.1_alternative_derivative.jpg?raw=1"))
</div>

__Alternative form of derivative__
```math
f'(c)=\lim_{x\to c}\frac{f(x)-f(c)}{x-c}
```

"""

# ╔═╡ 71e80540-7050-43b8-b126-ea4c232dfa17
cm"""
__Exercises__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 527c64a0-0353-440b-8ed8-9c7556168f76
md""" 
# 3.2: Basic Differentiation Rules and Rates of Change
__Objectives__
> - Find the derivative of a function using the Constant Rule.
> - Find the derivative of a function using the Power Rule.
> - Find the derivative of a function using the Constant Multiple Rule.
> - Find the derivative of a function using the Sum and Difference Rules.
> - Find the derivatives of the sine function and of the cosine function.
> - Find the derivatives of exponential functions.
> - Use derivatives to find rates of change.
"""

# ╔═╡ 0e8ebfac-87a8-49d4-93f5-fa41b4099f6a
md"## The Constant Rule"

# ╔═╡ e99258e8-bca7-4926-b93e-81c69fac45e9
md"## The Power Rule"

# ╔═╡ 6360916b-b0aa-471c-8b48-932983f35f76
md"## The Constant Multiple Rule"

# ╔═╡ db709ce9-82d4-4296-bb5c-63e417215ef0
md"## The Sum and Difference Rules"

# ╔═╡ 6d189698-df83-4955-bebf-fc997febef22
md"## Derivatives of the Sine and Cosine Functions"

# ╔═╡ c3e874ae-a802-48d9-b146-fd069574d4ce
md"## Derivatives of Exponential Functions"

# ╔═╡ b3c3ee35-b0d6-4be3-b427-5a2d1b03a4ca
cm"""
__Exercises__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 42d3edd7-831f-40b5-9cbc-0ce7b9e2305a
begin
	t = symbols("t", real=true)
	g(t)=-2cos(t)-5
	plot(x->g(x))
	diff(g(t),t)
end

# ╔═╡ a8a7e949-3b21-4c71-910b-1e360c4b3ea4
md"## Rates of Change"

# ╔═╡ 837eace3-6d49-4158-8765-f4c96eb1e9c2
cm"""
- The derivative can be used to determine the __rate of change__ of one variable with respect to another.
- Applications involving rates of change, sometimes referred to as __instantaneous rates of change__, occur in a wide variety of fields.
- A common use for rate of change is to describe __the motion of an object moving in 
a straight line.__ (+ direction and -direction)
- The function ``s`` that gives __the position (relative to the origin)__ of an object as a __function of time__ ``t`` is called a __position function__. If, over a period of time ∆t, the object changes its position by the amountthen, by the familiar formula
```math
\Delta s = s(t+\Delta t)-s(t)
```
- then, by the familiar formula
```math
\text{Rate} = \frac{\text{distance}}{\text{time}}.
```
-the average velocity is
```math
\frac{\text{Change in distance}}{\text{Change in time}}=\frac{\Delta s}{\Delta t}
\qquad \text{\color{red} Average Velocity}.
```
- In general, if ``s = s(t)`` is the position function for an object moving along a straight line, then the velocity of the object at time ``t`` is
```math
v(t) = \lim_{\Delta t\to 0}\frac{s(t+\Delta t)-s(t)}{\Delta t}=s'(t).
\qquad \text{\color{red} Velocity function}.
```


"""


# ╔═╡ 3bb4a5f1-b5bb-4cd6-b778-1993d15a3cb6
md"""
# 3.3: Product and Quotient Rules and Higher-Order Derivatives
__Objectives__
> - Find the derivative of a function using the Product Rule.
> - Find the derivative of a function using the Quotient Rule.
> - Find the derivative of a trigonometric function.
> - Find a higher-order derivative of a function.
"""

# ╔═╡ 8355593c-74e1-4441-b007-cc6b2303c23a
md"## The Product Rule"

# ╔═╡ 1068f775-fde6-41d7-9aa6-5c57e0eaaa77
md"## The Quotient Rule"

# ╔═╡ 108dc8da-4b6a-49d1-8dd4-5ecd22c542a3
md"## Derivatives of Trigonometric Functions"

# ╔═╡ 6ab25ebb-99bf-490d-bd92-4b8e0036426d
md"## Higher-Order Derivatives"

# ╔═╡ 30319bd0-e478-4f9d-9c48-275b9ba9e44a
cm"""
__Remarks__

__Rates of changes__
```math
\begin{array}{lllllll}
 & & & & s(t)&\qquad & \text{\color{red} Position function}\\
&  &v(t) &=& s'(t)&\qquad & \text{\color{red} Velocity function}\\
a(t)& = &v'(t)& = & s''(t)&\qquad & \text{\color{red} Acceleration function}
\end{array}
```

__Higher Derivatives__
```math
\begin{array}{lllll}
\textbf{First derivative:}& y', & f'(x), & \frac{dy}{dx}, & \frac{d}{dx}\left[f(x)\right], & D_x[y]\\ \\

\textbf{Second derivative:}& y'', & f''(x), & \frac{d^2y}{dx^2}, & \frac{d^2}{dx^2}\left[f(x)\right], & D^2_x[y]\\ \\

\textbf{Third derivative:}& y''', & f'''(x), & \frac{d^3y}{dx^3}, & \frac{d^3}{dx^3}\left[f(x)\right], & D^3_x[y]\\ \\

\textbf{Fourth derivative:}& y^{(4)}, & f^{(4)}(x), & \frac{d^4y}{dx^4}, & \frac{d^4}{dx^4}\left[f(x)\right], & D^4_x[y]\\ \\
\vdots \\ \\

\textbf{nth derivative:}& y^{(n)}, & f^{(n)}(x), & \frac{d^ny}{dx^n}, & \frac{d^n}{dx^n}\left[f(x)\right], & D^n_x[y]\\ \\

\end{array}
```

"""

# ╔═╡ 7c14ced9-4863-4315-b2e4-cd905e462b79
cm"""
__Exercises__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 396dc79a-824f-4a8e-9b0e-e5aa250f9cdd
md"""
# 3.4: The Chain Rule
__Objectives__
> - Find the derivative of a composite function using the Chain Rule.
> - Find the derivative of a function using the General Power Rule.
> - Simplify the derivative of a function using algebra.
> - Find the derivative of a transcendental function using the Chain Rule.
> - Find the derivative of a function involving the natural logarithmic function.
> - Define and differentiate exponential functions that have bases other than .
"""

# ╔═╡ eedffba5-fa2d-4c68-8a4e-f25a1e120ad0
md"## The Chain Rule"

# ╔═╡ 36a9bf9e-ac45-4aac-a431-a8434352aa2e
cm"""
__Examples__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ e46d78e1-243a-4b4f-9112-d324364d84ae
cm"""
## Transcendental Functions and the Chain Rule
```math
\begin{array}{lclrlcl}
\displaystyle\frac{d}{dx}\left[\sin u\right] &=& (\cos u)u' &,\quad&
\displaystyle\frac{d}{dx}\left[\cos u\right] &=& -(\sin u)u' \\

\displaystyle\frac{d}{dx}\left[\tan u\right] &=& (\sec^2 u)u' &,\quad&
\displaystyle\frac{d}{dx}\left[\cot u\right] &=& -(\csc^2 u)u' \\

\displaystyle\frac{d}{dx}\left[\sec u\right] &=& (\sec u\tan u)u' &,\quad&
\displaystyle\frac{d}{dx}\left[\csc u\right] &=& -(\csc u\cot u)u' \\

\displaystyle\frac{d}{dx}\left[e^u\right] &=& (e^u)u' \\

\end{array}
```
"""

# ╔═╡ 42487db3-df5d-4d1e-afda-9ec1ebbf4939
cm"""
__Examples__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 2add91dd-4e6c-4201-965b-680eb5f529ec
cm"""
__Examples__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ feb7b6b2-e0cf-48cc-bde8-5c8649fdb57b
md""" 
# 3.5: Implicit Differentiation
__objectives__
> - Distinguish between functions written in implicit form and explicit form.
> - Use implicit differentiation to find the derivative of a function.
> - Find derivatives of functions using logarithmic differentiation.
"""


# ╔═╡ 4e1655d7-a0e5-40fd-b89f-4105d3fd300c
md"## Logarithmic Differentiation"


# ╔═╡ efc29c6f-06ec-483e-b243-5c4cd178453b
cm"""
__Examples__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 2d351e50-6fc5-4362-bd4b-a563e71929b3
md"""
# 3.6: Derivatives of Inverse Functions
__Objectives__
> - Find the derivative of an inverse function.
> - Differentiate an inverse trigonometric function.
"""

# ╔═╡ d57b4627-d66d-446c-a9ad-2e9ea42954d8
cm"""
## Derivative of an Inverse Function

The graph of ``f^{-1}`` is a reflection of the graph of ``f`` in the line ``y=x``. 

<div class="img-container">

$(Resource("https://www.dropbox.com/scl/fi/1ofqbbb6cj7bfbxsrexfr/sec3.6_intro.jpg?rlkey=9dp9aep4nuy8x6q1a3b3rzltm&raw=1"))

</div>
"""

# ╔═╡ 0751712c-9870-46b0-83bc-93093cd0ce0e
md"""
## Derivatives of Inverse Trigonometric Functions
"""

# ╔═╡ 9a7a19ce-1cd7-47e1-9fc5-f8689b0ff5fd
cm"""
__Examples__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ 343aadc6-d64d-4c85-92f8-9787d6af549a
md"""# 3.7: Related Rates
__Objectives__
> - Find a related rate.
> - Use related rates to solve real-life problems.

## Finding Related Rates
"""

# ╔═╡ bc02e2d7-9144-4b02-9d4d-18677c69f072
md"## Problem Solving with Related Rates"

# ╔═╡ e383ae38-a6e2-4c7d-9de5-5040e41259f0
cm"""
In __Example 1__
- __Equation:__ ``y=x^2+3``.
- __Given:__ ``\displaystyle\frac{dx}{dt}=2`` when ``x=1``.
- __Find:__ ``\displaystyle\frac{dy}{dt}`` when ``x=1``.
"""

# ╔═╡ 9a903024-378d-48b1-8aaf-33e9ca846b62
md"""
# 3.8: Newton’s Method
__Objectives__
> - Approximate a zero of a function using Newton’s Method.
"""

# ╔═╡ e00a88c6-30f7-48e4-8f8a-ae46de9b4022
md"## Newton’s Method"

# ╔═╡ 3ac30596-2ff2-4005-9ada-328c3000bdf7
begin
	f(x)=x^2-2
	df(x)=2x
	x1=1
	x2=x1-f(x1)/df(x1)
	x3=x2-f(x2)/df(x2)
	x4=x3-f(x3)/df(x3)
end

# ╔═╡ a63e14fe-e7db-4195-97f4-d1195aeffcaa
cm"""
__Revision__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ d89b4f6d-fef7-4cd5-a570-d36148bec2b0
md"""
# 4.1: Extrema on an Interval
> - Understand the definition of extrema of a function on an interval.
> - Understand the definition of relative extrema of a function on an open interval.
> - Find extrema on a closed interval.
## Extrema of a Function
"""


# ╔═╡ 28b9e358-75a9-4ede-a08e-724c4b21b4e6
md"## Relative Extrema and Critical Numbers"

# ╔═╡ 9a8df83a-daba-4274-86d2-c54c9e38ed2d
md"## Finding Extrema on a Closed Interval"

# ╔═╡ 9f510483-f0eb-4e39-89bd-321f7b7931d4
cm"""
__Revision__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ dfa06187-b6f5-4548-bc6d-39ec9ffe7098
md"""
# 4.2: Rolle’s Theorem and the Mean Value Theorem
__Objectives__
> - Understand and use Rolle’s Theorem.
> - Understand and use the Mean Value Theorem.

## Rolle’s Theorem
"""

# ╔═╡ 1cd56567-aa5d-489e-a9b5-8f65d7df810b
md"## The Mean Value Theorem"

# ╔═╡ 200d1770-94aa-4780-8e13-a5b268236cec
cm"""
__Revision__
<div class="img-container">

$(Resource("https://www.dropbox.com/s/cat9ots4ausfzyc/qrcode_itempool.com_kfupm.png?raw=1",:width=>350))

</div>
"""

# ╔═╡ f0ce410f-d502-43af-8eed-a2e06aa0492e
md"""
# 4.3: Increasing and Decreasing Functions and the First Derivative Test
__Objectives__
> - Determine intervals on which a function is increasing or decreasing.
> - Apply the First Derivative Test to find relative extrema of a function.

## Increasing and Decreasing Functions
"""

# ╔═╡ b5107032-e1a0-42ed-9618-21e8228b2074
md"## The First Derivative Test"

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

# ╔═╡ 8c0e4e4b-eea3-4493-94c5-c932ad35c033
cm"""
$(beginBlock("Definition of a Horizontal Asymptote",""))

The line ``y=L`` is a __horizontal asymptote__ of the graph of ``f`` when
```math
\lim_{x\to -\infty} f(x) = L \quad \text{or}\quad \lim_{x\to \infty} f(x) = L
```
$(endBlock())
"""

# ╔═╡ 18142094-6fe8-401b-9901-4d27568400cc
cm"""
$(beginBlock("Remarks",""))
- Limits at infinity have many of the same properties of limits discussed in Section 2.3. 
- For example, if ``\displaystyle \lim_{x\to\infty}f(x)`` and ``\displaystyle \lim_{x\to\infty}g(x)`` both exist, then
	- ``\displaystyle \lim_{x\to\infty}\left[f(x)+g(x)\right]=\displaystyle \lim_{x\to\infty}f(x)+\displaystyle \lim_{x\to\infty}g(x)`` 
	- ``\displaystyle \lim_{x\to\infty}\left[f(x)g(x)\right]=\displaystyle \left[\lim_{x\to\infty}f(x)\right]\left[\displaystyle \lim_{x\to\infty}g(x)\right]`` 

- Similar properties hold for limits at ``-\infty``.
$(endBlock())
"""

# ╔═╡ 1578ef95-a110-4bd7-8166-f83400ccf956
cm"""
$(beginTheorem("Limits at Infinity"))
1. If ``r`` is a positive rational number and ``c`` is any real number, then
```math
\lim_{x\to\infty}\frac{c}{x^r}=0\quad \text{and}\quad \lim_{x\to-\infty}\frac{c}{x^r}=0
```
The second limit is valid only if ``x^r`` is defined when ``x<0``.

2. ``\displaystyle \lim_{x\to-\infty}e^x=0`` and ``\displaystyle \lim_{x\to\infty}e^{-x}=0``

"""

# ╔═╡ 51230edd-280c-4498-bac6-18a49c9c2e3d
cm"""
$(beginBlock("Guidelines for Finding Limits at ±∞ of Rational Functions",""))
```math
h(x)=\frac{p(x)}{q(x)}
```
1. ``\text{deg }p<\text{deg }q``, then the limit is ``0``.

2. ``\text{deg }p=\text{deg }q``, then the __limit__ of the rational function __is__ the __ratio__ of the __leading coefficients__.

3. ``\text{deg }p>\text{deg }q``, then the __limit__ of the rational function __does not exist__.

$(endBlock())
"""

# ╔═╡ 771e9f11-c410-4f09-b75f-18c07d815396
cm"""
$(beginBlock("Remark",""))
Determining whether a function has an infinite limit at infinity is useful in analyzing the __“end behavior”__ of its graph. You will see examples of this in Section 4.6 on curve sketching.

$(endBlock())
"""

# ╔═╡ e239e3b1-41d2-4eed-b808-714d765da70d
cm"""
$(beginBlock("Definition of Continuity",""))
__Continuity at a Point__

A function ``f`` is __continuous at ``c``__ when these three conditions are met.

1. ``f(c)`` is defined.

2. ``\displaystyle \lim_{x\to c}f(x)`` exists.
 
3. ``\displaystyle \lim_{x\to c}f(x)=f(c)``


__Continuity on an Open Interval__

- A function ``f`` is __continuous on an open interval ``(a,b)``__  when the function is continuous at each point in the interval. 
- A function that is continuous on the entire real number line ``(-\infty,\infty)`` is __everywhere continuous__.
$(endBlock())
"""

# ╔═╡ aae72f6c-6acd-452d-9a4b-114dfff0e251
cm"""
$(beginBlock("Remarks",""))
-  If a function ``f`` is defined on an open interval ``I`` (except possibly at ``c``), and ``f`` is not continuous at ``c``, then ``f`` is said to have a __discontinuity__ at ``c``.
- Discontinuities fall into two categories: 
	- __removable__:  A discontinuity at ``c`` is called removable when ``f`` can be made continuous by appropriately defining (or redefining) ``f(c)``.
	- __nonremovable__: there is no way to define ``f(c)`` so as to make the function continuous at ``x=c``.
$(endBlock())
"""

# ╔═╡ c39a783e-7902-4df5-90a5-9e792f07d50c
cm"""
$(example("Example 1",""))
Discuss the continuity of each function
```math
\begin{array}{ll}
\text{a. } &\displaystyle f(x)=\frac{1}{x} \\
\text{b. } &\displaystyle g(x)=\frac{x^2-1}{x-1} \\
\text{c. } &\displaystyle h(x)=\begin{cases}x+1, & x\leq 0\\ e^x,& x>0\end{cases} \\
\text{d. } &\displaystyle y=\sin x  
\end{array}
```

"""

# ╔═╡ ebfc7342-2088-4b5c-8655-7b9eb549daf7
cm"""
$(beginTheorem("The Existence of a Limit"))

Let ``f`` be a function, and let ``c`` and ``L`` be real numbers. The limit of ``f(x)`` as ``x`` approaches ``c`` is  if and only if

```math
\lim_{x\to c^-}f(x)=L \qquad \text{and}\qquad \lim_{x\to c^+}f(x)=L
```

$(endTheorem())

$(beginBlock("Definition of Continuity on a Closed Interval",""))

A function ``f`` is __continuous on the closed interval ``[a,b]``__ when ``f`` is continuous on the open interval ``(a,b)`` and
```math
\lim_{x\to a^+}f(x)=f(a)
```
and
```math
\lim_{x\to b^-}f(x)=f(b).
```


$(endBlock())
"""

# ╔═╡ 63520084-6d28-4df5-bb54-1da5d4cdf8e7
cm"""
$(example("Example 4","Continuity on a Closed Interval"))
Discuss the continuity of
```math
f(x)=\sqrt{1-x^2}
```
"""

# ╔═╡ 0885b9a6-d3eb-465c-aa8e-d1424c60bb11
cm"""
$(beginTheorem("Properties of Continuity"))

If ``b`` is a real number and ``f`` and ``g`` are continuous at ``x=c``, then the functions listed below are also continuous at ``c``.

1. __Scalar multiple:__ ``\quad bf`` 

2. __Sum or difference:__ ``\quad f\pm g`` 

3. __Product:__ ``\quad fg`` 

4. __Quotient:__ ``\displaystyle\quad \frac{f}{g}, \quad g(c)\ne 0`` , 
"""

# ╔═╡ fe8952fd-8033-4f65-a2c2-1e6a4134d633
cm"""
$(beginBlock("Remarks",""))
1. __Polynomials__ are continuous at every point in their domains.

2. __Rational functions__ are continuous at every point in their domains.

3. __Radical functions__ are continuous at every point in their domains.

4. __Trigonometric functions__ are continuous at every point in their domains. 

5. __Exponential and logarithmic functions__ are continuous at every point in their domains.
$(endBlock())
"""

# ╔═╡ bfb1598b-921f-4761-9527-7d7f88075bd5
cm"""
$(beginTheorem("Continuity of a Composite Function"))

If ``g`` is continuous at ``c`` and ``f`` is continuous at ``g(c)`` then the __composite function__ given by ``(f\circ g)(x)=f(g(x))`` is continuous at ``c``.

$(endTheorem())

$(beginBlock("Remark",""))
```math
\lim_{x\to c}{f(g(x))} = f(g(c))
```
provided ``f`` and ``g`` satisfy the conditions of the theorem.
$(endBlock())
"""

# ╔═╡ df1bf60f-2e41-4eda-9d07-f2aefc0c7cb7
cm"""
$(example("Example 7","Testing for Continuity"))

Describe the interval(s) on which each function is continuous.
```math
\begin{array}{ll}
\text{a. } &\displaystyle f(x)=\tan x \\
\text{b. } &\displaystyle g(x)=\begin{cases}\sin \frac{1}{x}, & x\ne 0\\ 0,& x=0\end{cases} \\
\text{c. } &\displaystyle h(x)=\begin{cases}x\sin \frac{1}{x}, & x\ne 0\\ 0,& x=0\end{cases} \\
\end{array}
```
"""

# ╔═╡ 769e5d3a-b537-4e70-83a7-d02f9767e87e
cm"""
$(beginTheorem("Intermediate Value Theorem"))
If ``f`` is continuous on the closed interval ``[a,b]``, ``f(a)\ne f(b)``, and ``k`` is any number between ``f(a)`` and ``f(b)`` then there is at least one number ``c`` in ``[a,b]`` such that
```math
f(c)=k.
```
$(endBlock())
"""

# ╔═╡ 8ad3b7ab-2999-4b7f-ac83-24207f0ce1c9
cm"""
$(example("Example 8","An Application of the Intermediate Value Theorem"))

Use the Intermediate Value Theorem to show that the polynomial function
```math
f(x) = x^3+2x-1
```
has a zero in the interval ``[0,1]``.
"""

# ╔═╡ 1b09c022-ef6e-4159-a947-e0500e9c2137
cm"""
$(beginBlock("Definition of Tangent Line with Slope",""))
If ``f`` is defined on an open interval containing ``c``, and if the limit
```math
\lim_{\Delta x\to 0}\frac{\Delta y}{\Delta x}=\lim_{\Delta x\to 0}\frac{f(c+\Delta x)-f(c)}{\Delta x}=m
```
exists, then the line passing through ``(c,f(c))`` with slope ``m`` is the __tangent line__ to the graph of ``f`` at the point ``(c,f(c))``.
$(endBlock())

$(beginBlock("Remark",""))
The slope of the tangent line to the graph of ``f`` at the point ``(c,f(c))`` is also called the __slope of the graph of ``f`` at ``x=c``__.
$(endBlock())
"""

# ╔═╡ b87bd0f8-9c4d-43e6-bd70-ab1f7aae3099
cm"""
$(example("Example 1","The Slope of the Graph of a Linear Function"))
Find the slope of the graph of ``f(x)=2x-3`` when ``c=2``.


$(example("Example 2","Tangent Lines to the Graph of a Nonlinear Function"))
Find the slopes of the tangent lines to the graph of ``f(x)=x^2+1`` at the points ``(0,1)`` and ``(-1,2)``.

"""


# ╔═╡ a723c237-59a8-458a-8e36-38ac47f510aa
cm"""
$(beginBlock("Remarks",""))
- The definition of a tangent line to a curve does not cover the possibility of a vertical tangent line. 
- For vertical tangent lines, you can use the __following definition__. If ``f`` is continuous at ``c`` and
```math
\lim_{\Delta x\to 0}\frac{f(c+\Delta x)-f(c)}{\Delta x}=\infty
\quad \text{or}\quad 
\lim_{\Delta x\to 0}\frac{f(c+\Delta x)-f(c)}{\Delta x}=-\infty
```
then the __vertical line  ``x=c``__ passing through ``(c,f(c))`` is a vertical tangent line to the graph of ``f``. 

$(endBlock())
"""

# ╔═╡ d21f6cf2-e355-40b4-91e5-0de2f2164f69
cm"""
$(beginBlock("Definition", "Derivative of a Function"))
The __derivative__ of ``f`` at ``x`` is
```math
f'(x)=\lim_{\Delta x\to 0}\frac{f(x+\Delta x)-f(x)}{\Delta x}
```
provided the limit exists. For all ``x`` for which this limit exists, ``f'`` is a function of ``x``.
$(endBlock())

$(beginBlock("Remarks", ""))
- The notation ``f'(x)`` is read as “``f`` prime of ``x``.”

- ``f'(x)`` is a __function__ that gives the slope of the tangent line to the graph of ``f`` at the point ``(x,f(x)``, provided that the graph has a tangent line at this point.

- The derivative can also be used to determine the __instantaneous rate of change__ (or simply the __rate of change__) of one variable with respect to another.

- The process of finding the derivative of a function is called __differentiation__.

- A function is __differentiable__ at ``x`` when its derivative exists at ``x`` and is __differentiable on an open interval ``(a,b)``__  when it is differentiable at every point in the interval.

$(endBlock()) 
"""

# ╔═╡ e6c41f43-ac50-40f9-9491-ff1596f7ef5e
cm"""
$(beginBlock("Notation",""))
```math
y=f(x)
```
- ``\displaystyle f'(x)``
- ``\displaystyle \frac{dy}{dx}``
- ``\displaystyle y'``
- ``\displaystyle \frac{d}{dx}\left[f(x)\right]``
- ``\displaystyle D_x[y]``
```math
\frac{dy}{dx} =\lim_{\Delta x\to 0}\frac{\Delta y}{\Delta x}=
\lim_{\Delta x\to 0}\frac{f(x+\Delta x)-f(x)}{\Delta x}
```
$(endBlock())
"""

# ╔═╡ 0f3fa154-58ad-4983-a1d4-860e49931439
cm"""
$(example("Examples 3,4,5","Finding the Derivative by the Limit Process"))
__Find the derivative of__

- ``\displaystyle f(x)=x^3+2x``
- ``\displaystyle f(x)=\sqrt{x}``
- ``\displaystyle y=\frac{2}{t}`` with respect to ``t``.
"""

# ╔═╡ 0096631e-e2c4-49ea-a9d9-e3bdd70f0423
cm"""
$(beginBlock("Remarks",""))
__derivative from the left__
```math
\lim_{x\to c^-}\frac{f(x)-f(c)}{x-c}
```

__derivative from the right__
```math
\lim_{x\to c^+}\frac{f(x)-f(c)}{x-c}
```
$(endBlock())

$(example("Example",""))
```math
f(x)=[[x]]
```
"""

# ╔═╡ d021c3ce-0118-4b87-a516-af471288a3ab
cm"""
$(example("Example 6","A Graph with a Sharp Turn"))
```math
f(x) =|x-2|
```

$(example("Example 7","A Graph with a Vertical Tangent Line"))
```math
f(x) =x^{\frac{1}{3}}
```
"""

# ╔═╡ 1944e59d-b4bf-4c16-8408-4c7e8dd9017b
cm"""
$(beginTheorem("Differentiability Implies Continuity"))
If ``f`` is differentiable at ``x=c``, then ``f`` is continuous at ``x=c``.

$(endTheorem())
"""

# ╔═╡ e9b58100-f297-4943-9eef-7f7cc39b2e6e
cm"""
$(beginBlock("remarks",""))
The relationship between continuity and differentiability is summarized below.

- If a function ``f`` is differentiable at ``x=c``, then it is continuous at ``x=c``. So, __differentiability__ implies (``\Rightarrow``) __continuity__.

- It is possible for a function to be continuous at ``x=c`` and not be differentiable at ``x=c``. So, __continuity does not imply differentiability__.

$(endBlock())
"""

# ╔═╡ fbb40a41-03a0-41b0-9a74-4120c1d2cde6
cm"""
$(beginTheorem("The Constant Rule"))
The derivative of a constant function is ``0``. That is, if ``c`` is a real number, then
```math
\frac{d}{dx}[c] = 0.
```
$(endTheorem())

"""

# ╔═╡ cbc35c5b-2612-4e68-9ed8-48412b384aef
cm"""
$(beginTheorem("The Power Rule"))
If ``n`` is a rational number, then the function ``f(x)=x^n`` is differentiable and
```math
\frac{d}{dx}[x^n] = nx^{n-1}.
```
For ``f`` to be differentiable at ``0``, ``n`` must be a number such that ``x^{n-1}`` is defined on an interval containing ``0``.
$(endTheorem())

"""

# ╔═╡ ae64fc18-142b-4d6f-bb06-1f487b167850
cm"""
$(beginTheorem("The Constant Multiple Rule"))

If ``f`` is a differentiable function and ``c`` is a real number, then ``cf`` is also differentiable and
```math
\frac{d}{dx}[cf(x)] = cf'(x).
```
‍
$(endTheorem())

"""

# ╔═╡ c061b6bf-8ee0-4552-8d76-e8c0151e816a
cm"""
$(beginTheorem("The Sum and Difference Rules"))

The sum (or difference) of two differentiable functions ``f`` and ``g`` is itself differentiable. Moreover, the derivative of ``f+g`` (or ``f-g``) is the sum (or difference) of the derivatives of ``f`` and ``g``.
```math
\begin{array}{lclrl}
\displaystyle\frac{d}{dx}\left[f(x)+g(x)\right] &=& f'(x) +g'(x) &\quad&\text{\color{red}{Sum Rule}}\\
\\
\displaystyle\frac{d}{dx}\left[f(x)-g(x)\right] &=& f'(x) -g'(x) &\quad&\text{\color{red}{Difference Rule}}\\
\end{array}
```
‍
$(endTheorem())
"""

# ╔═╡ 1a0bc590-09b4-4a3d-84d0-349e18bfd9d0
cm"""
$(beginTheorem("Derivatives of the Sine and Cosine Functions"))

```math
\begin{array}{lclrlcl}
\displaystyle\frac{d}{dx}\left[\sin(x)\right] &=& \cos x &,\quad&
\displaystyle\frac{d}{dx}\left[\cos(x)\right] &=& -\sin x
\\
\end{array}
```
‍
$(endTheorem())
"""

# ╔═╡ 318b2cdc-a626-4d56-9616-73aabb1cd20c
cm"""
$(beginTheorem("Derivative of the Natural Exponential Function"))

```math
\begin{array}{lclrlcl}
\displaystyle\frac{d}{dx}\left[e^{x}\right] &=& e^x
\\
\end{array}
```
‍
$(endTheorem())
"""

# ╔═╡ db2e8eaa-2ab8-4e28-b142-54c3ce14e4d3
cm"""
$(example("Example",""))
If a ball is thrown into the air with a velocity of ``4 m/s``, its height (in meters (m)) ``t`` seconds later is given by 
```math
y=4t-4.9t^2.
```
1. Find the average velocity for the time period from ``t=1`` to ``t=3``.

2. Find the instantaneous rate of change at ``t=2``.  

"""

# ╔═╡ 8f084112-5b71-492b-a806-96fd29acd141
cm"""
$(example("Example 11","Using the Derivative to Find Velocity"))

At time ``t=0``, a diver jumps from a platform diving board that is ``9.8`` meters above the water. The initial velocity of the diver is ``4.9`` meters per second. When does the diver hit the water? What is the diver’s velocity at impact?

"""

# ╔═╡ 3bd2721d-150e-4e44-88f4-d8866e1390b0
cm"""
$(beginTheorem("The Product Rule"))
The product of two differentiable functions ``f`` and ``g`` is itself differentiable. Moreover, the derivative of ``fg`` is the __first__ function __times__ the __derivative of the second__, __plus__ the __second__ function times the __derivative of the first__.

```math
\frac{d}{dx}\left[f(x)g(x)\right] = f(x)g'(x) + g(x)f'(x).
```

$(endTheorem())
"""

# ╔═╡ 017e316d-fb17-4464-a123-aa0071d7b0be
cm"""

$(example("Example",""))

Find the derivative of ``f(x)=xe^x``.
"""

# ╔═╡ 99d05ae2-3e06-41d0-b5d4-7b445d497ad1
cm"""
$(beginTheorem("The Quotient Rule"))
The quotient  of two differentiable functions ``f`` and ``g`` is itself differentiable at all values of  for which ``g(x)\neq 0``. Moreover, the derivative of ``f/g`` is given by the __denominator__ __times__ the __derivative of the numerator__ __minus__ the __numerator times the derivative of the denominator__, all __divided by__ the __square of the denominator__.

```math
\frac{d}{dx}\left[\frac{f(x)}{g(x)}\right] = \frac{g(x)f'(x)-f(x)g'(x)}{\left[g(x)\right]^2}, \qquad g(x)\neq 0.
```


$(endTheorem())

$(example("Example",""))
Find an equation of the tangent line to the graph of ``f(x)=\displaystyle \frac{3-(1/x)}{x+5}`` at ``(-1,1)``.


"""

# ╔═╡ df8ecdb9-bbaf-4e16-9f8c-262e50f9bd1c
cm"""
$(beginTheorem("Derivatives of Trigonometric Functions"))
```math
\begin{array}{rll|rll}
\frac{d}{dx}\left(\tan x\right) &=&\sec^2x &\frac{d}{dx}\left(\cot x\right) &=&-\csc^2x \\
\frac{d}{dx}\left(\sec x\right) &=&\sec x\tan x &\frac{d}{dx}\left(\csc x\right) &=&-\csc x\cot x \\

\end{array}
```

$(endTheorem())

$(example("Example",""))
Differentiate 
```math
y = \frac{1-\cos x}{\sin x}
```
"""

# ╔═╡ 118501bb-51d3-471b-9414-09285b75f0aa
cm"""
$(beginTheorem("The Chain Rule"))

If ``y=f(u)`` is a differentiable function of ``u`` and ``u=g(x)`` is a differentiable function of ``x``, then ``y=f((x))`` is a differentiable function of ``x`` and 

```math
\frac{dy}{dx}=\frac{dy}{du}\cdot\frac{du}{dx}
```

or, equivalently,

```math
\frac{d}{dx}\left[f(g(x))\right]=f'(g(x))g'(x)
```


$(endTheorem())

"""

# ╔═╡ cc139ded-19c6-4d71-bb36-5ca5e0e57ea4
cm"""
$(beginBlock("Remark",""))
``{\color{red} \blacksquare}``: Outer function ``\;\;\quad``
``{\color{cyan} \blacksquare}``: Inner function 
```math
\text{If}\quad y={\color{red} f}({\color{cyan} g(x)}) ={\color{red} f}({\color{cyan} u}), \text{ then } 
```

```math
y'=\frac{dy}{dx}={\color{red} f'}({\color{cyan} g(x)}){\color{cyan} g'(x)}
```
or, equivalently 
```math
y'=\frac{dy}{dx}={\color{red} f'}({\color{cyan} u})\frac{d{\color{cyan} u}}{dx}
```

$(endBlock())

"""

# ╔═╡ dae123ab-a366-4a85-a852-c8c1c87152fa
cm"""
$(example("Example","Using the Chain Rule"))
Find ``\displaystyle \frac{dy}{dx}`` for
```math
y=\left(x^2+1\right)^3.
```

"""

# ╔═╡ 362f0a6f-a92f-489c-a499-6c4cbb12338f
cm"""
## The General Power Rule
$(beginTheorem("The General Power Rule"))
If ``y=\left[u(x)\right]^n``, where ``u`` is a differentiable function of ``x`` and  is a rational ``n`` number, then
```math
\frac{dy}{dx}=n\left[u(x)\right]^{n-1}\frac{dy}{dx}
```
or, equivalently,
```math
\frac{d}{dx}\left[u(x)\right]^n=n\left[u\right]^{n-1}u'
```
$(endTheorem())
"""

# ╔═╡ 7cf34ea2-72f3-4fc9-9bd6-0803b4684102
cm"""
$(example("Example",""))
Find the derivative of ``\displaystyle y=(3x-2x^2)^3``.
"""

# ╔═╡ 742aca52-5bc4-455c-bd1e-2e88a6d7a043
cm"""
## Simplifying Derivatives
$(example("Example",""))
Find the derivative of 
1. ``\displaystyle f(x)=x^2\sqrt{1-x^2}``.
1. ``\displaystyle f(x)=\frac{x}{\sqrt[3]{x^2+4}}``.
"""

# ╔═╡ 1bb2c077-27f1-47c0-978a-bccd8df1b487
cm"""
## The Derivative of the Natural Logarithmic Function

$(beginTheorem("Derivative of the Natural Logarithmic Function"))
Let ``u`` be a differentiable function of ``x``.
1. ``\displaystyle \frac{d}{dx}\left[\ln x\right]=\frac{1}{x}``, ``x>0``
2. ``\displaystyle \frac{d}{dx}\left[\ln u\right]=\frac{1}{u}\frac{du}{dx}=\frac{u'}{u}``, ``x>0``
$(endTheorem())

"""

# ╔═╡ d3076cdb-2550-42bc-b2c1-0c6b303432af
cm"""
$(beginTheorem("Derivative Involving Absolute Value"))
If ``u`` is a differentiable function of ``x`` such that ``u\ne 0``, then
```math
\displaystyle \frac{d}{dx}\left[\ln |u|\right]=\frac{u'}{u}
```

$(endTheorem())
"""

# ╔═╡ b3e1f838-ca23-409b-afc3-2ca42fb09d8d
cm"""
$(example("Examples",""))
Find ``y'`` for
1. ``\displaystyle y=\ln\sqrt{x+1}``
1. ``\displaystyle y=\left(\frac{3x-1}{x^2+3}\right)^2``
1. ``\displaystyle y=\ln{\left[\frac{x(x^2+1)^2}{\sqrt{2x^3+1}}\right]}``
"""

# ╔═╡ 4b68b602-31aa-455f-a409-6afb9405e2cf
cm"""
## Bases Other than ``e``
$(beginBlock("Definition of Exponential Function to Base a","")) 
If ``a`` is a positive real number (``a\ne 1``)  and ``x`` is any real number, then the __exponential function to the base ``a``__ is denoted by ``a^x`` and is defined by
```math
a^x = e^{x\ln a}
```

If ``a=1`` , then ``y=1^x=1`` is a constant function.
$(endBlock())
"""

# ╔═╡ a26898e0-0f90-45b5-b789-397371c9ba65
cm"""
$(beginBlock("Definition of Logarithmic Function to Base a","")) 
If ``a`` is a positive real number (``a\ne 1``)  and ``x`` is any __positive__ real number, then the __logarithmic function to the base ``a``__ is denoted by ``\log_a x`` and is defined by
```math
\log_a x = \frac{1}{\ln a}\ln x.
```
$(endBlock())
"""

# ╔═╡ d08fad11-d915-4f2f-a9f8-6f42e2a8da79
cm"""
$(beginTheorem("Derivatives for Bases Other than e"))

Let ``a`` be a positive real number (``a\ne 1``) and let ``u`` be a differentiable function of ``x``.
1. ``\displaystyle \frac{d}{dx}[a^x] = (\ln a)a^x``
1. ``\displaystyle \frac{d}{dx}[a^u] = (\ln a)a^u\frac{du}{dx}``
1. ``\displaystyle \frac{d}{dx}[\log_a^x] = \frac{1}{(\ln a)x}``
1. ``\displaystyle \frac{d}{dx}[\log_a^u] = \frac{1}{(\ln a)u}\frac{du}{dx}``

$(endTheorem())
"""

# ╔═╡ 39c79294-3abd-4b1b-9668-b5bc9c0c7c66
cm"""
$(example("Example","Implicit Differentiation"))
Find ``\displaystyle \frac{dy}{dx}`` given that ``y^3+y^2-5y-x^2=-4``.
"""

# ╔═╡ 826cfc53-5797-476a-a185-4bee6d4b357c
cm"""
$(beginBlock("Guidelines for Implicit Differentiation",""))
1. Differentiate both sides of the equation with respect to ``x``.

2. Collect all terms involving ``\frac{dy}{dx}`` on the left side of the equation and move all other terms to the right side of the equation.

3. Factor ``\frac{dy}{dx}`` out of the left side of the equation.

4. Solve for ``\frac{dy}{dx}``.
$(endBlock())
"""

# ╔═╡ 889c445a-1a62-4467-96a3-3f0974091068
cm"""
$(example("Example","Finding the Slope of a Graph Implicitly"))
Determine the slope of the graph of
```math
3(x^2+y^2)^2=100xy
```
at the point ``(3,1)``.

"""

# ╔═╡ d1f90c93-760e-472d-ab72-4c6c0a8cb3f0
cm"""
$(example("Example","Determining a Differentiable Function"))

Find ``\frac{dy}{dx}`` implicitly for the equation ``\sin y =x``. 
Then find the largest interval of the form ``-a < y < a`` on which ``y`` is a differentiable function of ``x``.

$(example("Example","Finding the Second Derivative Implicitly"))
Given ``x^2+y^2=25``, find ``\frac{d^2y}{dx^2}``.


"""

# ╔═╡ ea54d534-c6d7-4de4-a55f-a02c9266bec1
cm"""
$(beginBlock("Definition","Normal Line"))
The normal line at a point is the line __perpendicular__ to the tangent line at the point.
$(endBlock())

$(example("Example (exercise 63)","Normal Lines"))
Find the equations for the tangent line and normal line to the circle
```math
x^2+y^2=25
```
at the points ``(4,3)`` and ``(-3,4)``.

"""

# ╔═╡ 05b7bc32-f94d-42f5-ae63-91391da72ca4
cm"""
$(example("Example","Logarithmic Differentiation"))
Find the derivative of
1. ``\displaystyle y=\frac{(x-2)^2}{\sqrt{x^2+1}}, \qquad x\ne 2.``
1. ``\displaystyle y=x^{2x}, \qquad x>0.``
1. ``\displaystyle y=x^{\pi}.``
"""

# ╔═╡ ca507a8c-e4ba-4498-8a49-0fddac4c7209
cm"""
$(beginBlock("Definition","Orthogonal Trajectories"))
Two graphs (curves) are __orthogonal__ if at their point(s) of intersection, their __tangent lines__ are __perpendicular__ to each other.
$(endBlock())
"""

# ╔═╡ 05849508-ceec-4f3f-80c2-dad48921b0b0
cm"""

$(example("Excercise 81",""))

Are the following curves __orthogonal__?

```math
2x^2+y^2 = 6,\qquad y^2=4x
```

"""

# ╔═╡ 79acf8f3-f34b-479d-8fbb-4cfba272865b
cm"""
$(beginTheorem("Continuity and Differentiability of Inverse Functions"))
Let ``f`` be a function whose domain is an interval ``I`` . If ``f`` has an inverse function, then the following statements are true.

1. If ``f`` is continuous on its domain, then ``f^{-1}`` is continuous on its domain.

2. If ``f`` is differentiable on an interval containing ``c`` and ``f'(c)\ne 0``, then ``f^{-1}`` is differentiable at ``f(c)``.
$(endTheorem())
"""

# ╔═╡ 26f7d04b-63df-4011-8284-af82913a0e01
cm"""
$(beginTheorem("The Derivative of an Inverse Function"))
Let ``f`` be a function that is differentiable on an interval ``I`` . If ``f`` has an inverse function ``g``, then ``g`` differentiable at any ``x`` for which ``f'(g(x))\ne 0``. Moreover,
```math
g'(x) = \frac{1}{f'(g(x))}, \quad f'(g(x))\ne 0
```
$(endTheorem())
"""

# ╔═╡ c377f410-c7a8-4ae4-a901-c7e11066f8cc
cm"""
$(example("Example","Graphs of Inverse Functions Have Reciprocal Slopes"))
Let ``f(x)=x^2,\quad x\geq 0``. Find
1. ``f^{-1}(x)``
2. Find the slopes of the graphs of ``f`` and ``f^{-1}`` at the points ``(2,4)`` and ``(4,2)`` respectively
"""

# ╔═╡ 96700860-baf9-4324-96df-1f54acdee690
cm"""
$(beginTheorem("Derivatives of Inverse Trigonometric Functions"))
Let ``u`` be a differentiable function of ``x``.
```math
\begin{array}{lclrlcl}
\displaystyle\frac{d}{dx}\left[\sin^{-1} u\right] &=& \frac{u'}{\sqrt{1-u^2}} &,\quad&
\displaystyle\frac{d}{dx}\left[\cos^{-1} u\right] &=& \frac{-u'}{\sqrt{1-u^2}} \\
\displaystyle\frac{d}{dx}\left[\tan^{-1} u\right] &=& \frac{u'}{1+u^2} &,\quad&
\displaystyle\frac{d}{dx}\left[\cot^{-1} u\right] &=& \frac{-u'}{1+u^2} \\
\displaystyle\frac{d}{dx}\left[\sec^{-1} u\right] &=& \frac{u'}{|u|\sqrt{u^2-1}} &,\quad&
\displaystyle\frac{d}{dx}\left[\csc^{-1} u\right] &=& \frac{-u'}{|u|\sqrt{u^2-1}} \\
\end{array}
```
$(endTheorem())
"""

# ╔═╡ b868c935-c8f8-4d54-9cdc-fa9c2001750a
cm"""
$(example("Example 1","Two Rates That Are Related"))
The variables ``x`` and ``y`` are both differentiable functions of ``t`` and are related by the equation ``y=x^2+3``. Find ``\frac{dy}{dt}`` when ``x=1``, given that ``\frac{dx}{dt}=2``  when ``x=1``.
"""

# ╔═╡ 9f39ee00-2354-4241-87e6-8241b5b64748
cm"""
$(beginBlock("Guidelines for Solving Related-Rate Problems",""))
1. Identify all given quantities and quantities to be determined. Make a sketch and label the quantities.
2. Write an equation involving the variables whose rates of change either are given or are to be determined.
3. Using the Chain Rule, implicitly differentiate both sides of the equation with respect to time ``t``.
4. After completing __Step 3__, substitute into the resulting equation all known values for the variables and their rates of change. Then solve for the required rate of change.
$(endBlock())
"""

# ╔═╡ 162a9893-3284-43d9-874e-3d2da83de481
cm"""
$(example("Example 2","Ripples in a Pond"))
A pebble is dropped into a calm pond, causing ripples in the form of concentric circles, as shown in 
<div class="img-container">

$(Resource("https://www.dropbox.com/scl/fi/tsa1y6h4mzrxgh90mgu7g/sec3.7_ex2.jpg?rlkey=83t5mx5ouq5pykxxb4l5b99yf&raw=1"))
</div>

The radius ``r`` of the outer ripple is increasing at a constant rate of ``0.5`` meter per second. When the radius is ``2`` meters, at what rate is the total area ``A`` of the disturbed water changing?
"""

# ╔═╡ 7dda28f9-d181-4535-ac9d-23dce03579dc
cm"""
$(example("Example 3","An Inflating Balloon"))

Air is being pumped into a spherical balloon at a rate of ``1.5`` cubic meters per minute. Find the rate of change of the radius when the radius is ``2`` meters
"""

# ╔═╡ 8cbe782a-be10-4134-966a-0432d50ef817
cm"""
$(example("Example 4","The Speed of an Airplane Tracked by Radar"))

An airplane is flying on a flight path that will take it directly over a radar tracking station shown
<div class="img-container">

$(Resource("https://www.dropbox.com/scl/fi/8uyfzay6vkxnv2cb5xqd6/sec3.7_ex4.jpg?rlkey=9mm8uvpw7r5b3bdxgg5qjao41&raw=1"))
</div>

The distance ``s`` is decreasing at a rate of ``400`` kilometers per hour when ``s=10`` kilometers. What is the speed of the plane?
"""

# ╔═╡ 6fcbc28c-a73f-42b2-a324-6a028210a7c4
cm"""
$(example("Example 5","A Changing Angle of Elevation"))

Find the rate of change in the angle of elevation of the camera shown in 
<div class="img-container">

$(Resource("https://www.dropbox.com/scl/fi/q6yhhiq03sk9mi5o5cqc1/sec3.7_ex5.jpg?rlkey=v2xdeip3io52qwzm9u8o2xu3u&raw=1"))
</div>

at ``10`` seconds after lift-off.
"""

# ╔═╡ 9450e9c6-3f97-4e12-812b-a16d6a2591c3
cm"""
$(example("Excercise 17",""))

At a sand and gravel plant, sand is falling off a conveyor and onto a conical pile at a rate of ``10`` cubic meters per minute. The diameter of the base of the cone is approximately three times the altitude. At what rate is the height of the pile changing when the pile is ``4`` meters high? (Hint: The formula for the volume of a cone is ``\displaystyle V=\frac{1}{3}\pi r^2h``.)
"""

# ╔═╡ 6b546815-890e-4cab-9435-f036491c2a3f
cm"""
$(beginBlock("Newton’s Method for Approximating the Zeros of a Function",""))

Let ``f(c)=0``, where ``f`` is differentiable on an open interval containing ``c``. Then, to approximate , use these steps.

1. Make an initial estimate ``x_1`` that is close to ``c`` . (A graph is helpful.)

2. Determine a new approximation
```math
x_{n+1}=x_n-\frac{f(x_n)}{f'(x_n)}
```

3. When ``|x_{n+1}-x_n|`` is within the desired accuracy, let ``x_{n+1}`` serve as the final approximation. Otherwise, return to Step 2 and calculate a new approximation.

Each successive application of this procedure is called an __iteration__.
$(endBlock())
"""

# ╔═╡ e65e9cd4-b085-4fb3-b85a-267f94dde8c3
cm"""
$(example("Example 1","Using Newton’s Method"))
Calculate three iterations of Newton’s Method to approximate a zero of ``f(x)=x^2-2``. Use ``x_1=1`` as the initial guess.
"""

# ╔═╡ d6607daf-ff39-47ce-b6c9-ff56c79ff69c
cm"""
$(example("Example 2","Using Newton’s Method"))
Use Newton’s Method to approximate the zero(s) of
```math
f(x)=e^x+x
```
Continue the iterations until two successive approximations differ by less than ``0.0001`` .
"""

# ╔═╡ 356b78ed-4e24-41dd-b65f-ec4f39ddb20e
cm"""
$(example("Example 3","An Example in Which Newton’s Method Fails"))
The function ``f(x)=x^{1/3}`` is not differentiable at ``x=0``. Show that Newton’s Method fails to converge using ``x_1=0.1``.
"""

# ╔═╡ ce287603-54eb-42ed-8f72-1769f560c68e
cm"""
$(beginBlock("Definition of Extrema",""))

Let ``f`` be defined on an interval ``I`` containing ``c``.

1. ``f(c)`` is the __minimum of ``f`` on ``I``__ when ``f(c)\leq f(x)`` for all ``x`` in ``I``.

2. ``f(c)`` is the __maximum of ``f`` on ``I``__ when ``f(c)\geq f(x)`` for all ``x`` in ``I``.

- The __minimum__ and __maximum__ of a function on an interval are the __extreme values__, or __extrema__ (the singular form of extrema is extremum), of the function on the interval. 
- The __minimum__ and __maximum__ of a function on an interval are also called the __absolute minimum__ and __absolute maximum__, or the __global minimum__ and __global maximum__, on the interval. Extrema can occur at interior points or endpoints of an interval. 
- __Extrema__ that occur at the endpoints are called __endpoint extrema__.
$(endBlock())
"""

# ╔═╡ 12d76fc1-5856-434e-aeca-69e78d0d0903
cm"""
$(beginTheorem("The Extreme Value Theorem"))
If ``f`` is __continuous__ on a __closed interval ``[a,b]``__ , then ``f`` has both a __minimum__ and a __maximum__ on the interval.
$(endTheorem())
"""

# ╔═╡ 77a9b72d-bb4f-40ba-ab75-c4c2ca97a1ad
cm"""
$(beginBlock("Definition of Relative Extrema",""))
1. If there is an open interval containing ``c`` on which ``f(c)`` is a __maximum__, then ``f(c)`` is called a __relative maximum of ``f``__, or you can say that ``f`` has a __relative maximum at ``(c,f(c))``__.

2. If there is an open interval containing ``c`` on which ``f(c)`` is a __minimum__, then ``f(c)`` is called a __relative minimum of ``f``__, or you can say that ``f`` has a __relative minimum at ``(c,f(c))``__.

- The __plural__ of relative maximum is __relative maxima__, and 
- the __plural__ of relative minimum is __relative minima__. 
- __Relative maximum__ and __relative minimum__ are sometimes called __local maximum__ and __local minimum__, respectively.

$(endBlock())
"""

# ╔═╡ af0a79aa-5cf7-45ad-8680-0eeb953df369
cm"""
$(beginBlock("Definition of a Critical Number",""))
Let ``f`` be defined at ``c``. If ``f'(c)=0`` or if ``f`` is not differentiable at ``c``, then ``c`` is a __critical number__ of ``f``.
$(endBlock())

$(beginTheorem("Relative Extrema Occur Only at Critical Numbers"))
If ``f`` has a relative minimum or relative maximum at ``c``, then ``c`` is a critical number of ``f``.
$(endTheorem())

"""

# ╔═╡ 1bebdd41-f2c5-4576-8100-c331e2d0164b
cm"""
$(beginBlock("Guidelines for Finding Extrema on a Closed Interval",""))

To find the extrema of a continuous function ``f`` on a closed interval ``[a,b]``, use these steps.

1. Find the __critical numbers__ of ``f`` in ``(a,b)``.

2. Evaluate ``f`` at each critical number in ``(a,b)``.

3. Evaluate ``f`` at each endpoint of ``[a,b]``..

4. The least of these values is the minimum. The greatest is the maximum.
$(endBlock())
"""

# ╔═╡ f927c000-2489-401e-a39b-554d56162099
cm"""
$(example("Example 2","Finding Extrema on a Closed Interval"))
Find the extrema of 
```math
f(x)=3x^4-4x^3
```
on the interval ``[-1,2]``.

$(example("Example 3","Finding Extrema on a Closed Interval"))
Find the extrema of 
```math
f(x)=2x-3x^{2/3}
```
on the interval ``[-1,3]``.

$(example("Example 4","Finding Extrema on a Closed Interval"))
Find the extrema of 
```math
f(x)=2\sin x - \cos 2x
```
on the interval ``[0,2\pi]``.
"""

# ╔═╡ b266bff3-1990-4ded-b7f4-a1f0d8e622fe
cm"""
$(beginTheorem("Rolle’s Theorem"))

Let ``f`` be continuous on the closed interval ``[a,b]`` and differentiable on the open interval ``(a,b)``. If ``f(a)=f(b)``, then there is at least one number ``c`` in ``(a,b)`` such that ``f'(c)=0``.
$(endTheorem())
"""

# ╔═╡ 447920f6-9120-47e0-a46c-0a217bdfc1af
cm"""
$(example("Example 1","Illustrating Rolle’s Theorem"))

Find the two ``x``-intercepts of
```math
f(x)=x^2-3x+2
```
and show that ``f'(x)=0`` at some point between the two ``x``-intercepts.

$(example("Example 2","Illustrating Rolle’s Theorem"))
Let ``f(x)=x^4-2x^2``. Find all values of ``c`` in the interval ``(-2,2)`` such that ``f'(c)=0``.
"""

# ╔═╡ 3746f3eb-c4d8-4461-ad53-c9f7bb04f385
cm"""
$(beginTheorem("The Mean Value Theorem"))
If ``f`` is continuous on the closed interval ``[a,b]`` and differentiable on the open interval ``(a,b)``, then there exists a number ``c`` in ``(a,b)`` such that
```math
f'(c)=\frac{f(b)-f(a)}{b-a}.
```
$(endTheorem())
"""

# ╔═╡ b8acea39-63e8-45fa-8214-eb8e6f13ff96
cm"""
$(example("Example",""))
Consider the graph of the function ``f(x)=-x^2+5``.

1. Find the equation of the secant line joining the points ``(-1,4)`` and ``(2,1)``.
2. Use the Mean Value Theorem to determine a point ``c`` in the interval ``(-1,2)`` such that the tangent line at ``c`` is parallel to the secant line.
3. Find the equation of the tangent line through ``c``.
"""

# ╔═╡ b3fb3115-9c50-4bef-bdf5-28c9f424d331
cm"""
$(beginBlock("Definitions of Increasing and Decreasing Functions",""))

- A function ``f`` is __increasing__ on an interval when, for any two numbers ``x_1`` and ``x_2`` in the interval, ``x_1<x_2`` implies ``f(x_1)<f(x_2)``.
- A function ``f`` is __descreasing__ on an interval when, for any two numbers ``x_1`` and ``x_2`` in the interval, ``x_1<x_2`` implies ``f(x_1)>f(x_2)``.

$(endBlock())
"""

# ╔═╡ 53ddfdbb-3e5b-4b29-abfd-8b86ef46529d
cm"""
$(beginTheorem("Test for Increasing and Decreasing Functions"))

Let ``f`` be a function that is continuous on the closed interval ``[a,b]`` and differentiable on the open interval ``(a,b)``.

1. If ``f'(x)>0`` for all ``x`` in ``(a,b)``, then ``f`` is __increasing__ on ``[a,b]``.
1. If ``f'(x)<0`` for all ``x`` in ``(a,b)``, then ``f`` is __decreasing__ on ``[a,b]``.
1. If ``f'(x)=0`` for all ``x`` in ``(a,b)``, then ``f`` is __constant__ on ``[a,b]``.

$(endTheorem())
"""

# ╔═╡ d5fc9ba7-376b-4322-a744-2c960d3e649e
cm"""
$(example("Example 1","Intervals on Which  Is Increasing or Decreasing"))
Find the open intervals on which ``f(x)=x^3-\frac{3}{2}x^2`` is increasing or decreasing.
"""

# ╔═╡ e5c83d3d-d793-46c3-8f58-8ed5cdd2a909
cm"""
$(beginTheorem("The First Derivative Test"))

Let ``c`` be a critical number of a function ``f`` that is continuous on an open interval ``I`` containing ``c``. If ``f`` is differentiable on the interval, except possibly at ``c``, then ``f(c)`` can be classified as follows.

1. If ``f'(x)`` changes from negative to positive at ``c``, then ``f`` has a __relative minimum at ``c``__.

2. If ``f'(x)`` changes from positive to negative at ``c``, then ``f`` has a __relative maximum at ``c``__.

3. If ``f'(x)`` is positive on both sides of ``c`` or negative on both sides of ``c``, then ``f(c)`` is neither a relative minimum nor a relative maximum.
$(endTheorem())
"""

# ╔═╡ 0bddc2a4-e177-48fc-b719-590fb9bfa51d
cm"""
$(example("Example 2","Applying the First Derivative Test"))

Find the relative extrema of 
```math
f(x)=\frac{1}{2}x-\sin x
```
in the interval ``(0,2\pi)``.

$(example("Example 3","Applying the First Derivative Test"))

Find the relative extrema of 
```math
f(x)=\left(x^2-4\right)^{2/3}.
```

$(example("Example 4","Applying the First Derivative Test"))

Find the relative extrema of 
```math
f(x)=\frac{x^4+1}{x^2}.
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

# ╔═╡ d4d13cb6-2162-4ac3-ac2f-8837c1084e53
function rotate_xy(θ =-π/20)	
	x,y,xp,yp = symbols("x,y,xp,yp", real=true)
	Mv= [cos(θ) -sin(θ);sin(θ) cos(θ)]*[x;y]
	sol=solve([xp-Mv[1],yp-Mv[2]],[x,y])
	sol[x],sol[y]
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

julia_version = "1.9.2"
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
version = "1.0.5+0"

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
version = "1.9.2"

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
version = "5.8.0+0"

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
# ╟─8c0e4e4b-eea3-4493-94c5-c932ad35c033
# ╟─18142094-6fe8-401b-9901-4d27568400cc
# ╟─1578ef95-a110-4bd7-8166-f83400ccf956
# ╟─51230edd-280c-4498-bac6-18a49c9c2e3d
# ╟─fcb34469-c7bc-4e1e-9cda-8ba0bc6cd23a
# ╠═eb67c3a6-38fe-4cd5-98fd-37028d40c136
# ╟─ae67e747-c131-40f8-ac4a-736934d6b5b4
# ╟─771e9f11-c410-4f09-b75f-18c07d815396
# ╟─f9476d3e-3837-42c9-9e11-95097a6b2373
# ╟─26a599c7-e877-4f73-a234-c41eff8d8e1c
# ╟─32275e49-51e9-4aa1-bb01-3bbfea0edd64
# ╟─e239e3b1-41d2-4eed-b808-714d765da70d
# ╟─aae72f6c-6acd-452d-9a4b-114dfff0e251
# ╟─c39a783e-7902-4df5-90a5-9e792f07d50c
# ╟─fb24f85a-0feb-4f51-beb7-caa0910821a0
# ╟─12b2f6cf-6c12-4d3e-83fe-f6880ac86a80
# ╟─e77cda7c-2a23-4e22-9df9-3ec75f35ba1c
# ╟─de60d9c6-36ed-4212-9172-76fc23e0732f
# ╟─ebfc7342-2088-4b5c-8655-7b9eb549daf7
# ╟─63520084-6d28-4df5-bb54-1da5d4cdf8e7
# ╟─9ea783cf-173e-4a8a-8be7-dc8c7d03da89
# ╟─0885b9a6-d3eb-465c-aa8e-d1424c60bb11
# ╟─fe8952fd-8033-4f65-a2c2-1e6a4134d633
# ╟─bfb1598b-921f-4761-9527-7d7f88075bd5
# ╟─df1bf60f-2e41-4eda-9d07-f2aefc0c7cb7
# ╟─911f9cdf-f753-4034-adc4-7e598610735a
# ╟─afceaec3-6d71-48d0-b456-47fcbd9f4b85
# ╟─769e5d3a-b537-4e70-83a7-d02f9767e87e
# ╟─8ad3b7ab-2999-4b7f-ac83-24207f0ce1c9
# ╟─161c840c-8309-41ee-b41c-4f5f7d622762
# ╟─9306823c-46fa-40a6-bdc8-2b60669040a6
# ╟─866720a0-cd9b-448d-8832-f9fb098e0bfb
# ╟─ef9db5e3-a380-4962-bc2c-765f1bbb3ff3
# ╟─1b09c022-ef6e-4159-a947-e0500e9c2137
# ╟─b87bd0f8-9c4d-43e6-bd70-ab1f7aae3099
# ╟─a723c237-59a8-458a-8e36-38ac47f510aa
# ╟─6c1ebc93-5c8f-46d0-983e-661a15aa7d17
# ╟─d21f6cf2-e355-40b4-91e5-0de2f2164f69
# ╟─e6c41f43-ac50-40f9-9491-ff1596f7ef5e
# ╟─0f3fa154-58ad-4983-a1d4-860e49931439
# ╟─858f00d8-0d8d-473a-933a-2fe8eda40239
# ╟─1bbe720c-deeb-4efd-aed2-65d1660536d3
# ╟─0096631e-e2c4-49ea-a9d9-e3bdd70f0423
# ╟─d021c3ce-0118-4b87-a516-af471288a3ab
# ╟─1944e59d-b4bf-4c16-8408-4c7e8dd9017b
# ╟─e9b58100-f297-4943-9eef-7f7cc39b2e6e
# ╟─71e80540-7050-43b8-b126-ea4c232dfa17
# ╟─527c64a0-0353-440b-8ed8-9c7556168f76
# ╟─0e8ebfac-87a8-49d4-93f5-fa41b4099f6a
# ╟─fbb40a41-03a0-41b0-9a74-4120c1d2cde6
# ╟─e99258e8-bca7-4926-b93e-81c69fac45e9
# ╟─cbc35c5b-2612-4e68-9ed8-48412b384aef
# ╟─6360916b-b0aa-471c-8b48-932983f35f76
# ╟─ae64fc18-142b-4d6f-bb06-1f487b167850
# ╟─db709ce9-82d4-4296-bb5c-63e417215ef0
# ╟─c061b6bf-8ee0-4552-8d76-e8c0151e816a
# ╟─6d189698-df83-4955-bebf-fc997febef22
# ╟─1a0bc590-09b4-4a3d-84d0-349e18bfd9d0
# ╟─c3e874ae-a802-48d9-b146-fd069574d4ce
# ╟─318b2cdc-a626-4d56-9616-73aabb1cd20c
# ╟─b3c3ee35-b0d6-4be3-b427-5a2d1b03a4ca
# ╠═42d3edd7-831f-40b5-9cbc-0ce7b9e2305a
# ╟─a8a7e949-3b21-4c71-910b-1e360c4b3ea4
# ╟─837eace3-6d49-4158-8765-f4c96eb1e9c2
# ╟─db2e8eaa-2ab8-4e28-b142-54c3ce14e4d3
# ╟─8f084112-5b71-492b-a806-96fd29acd141
# ╟─3bb4a5f1-b5bb-4cd6-b778-1993d15a3cb6
# ╟─8355593c-74e1-4441-b007-cc6b2303c23a
# ╟─3bd2721d-150e-4e44-88f4-d8866e1390b0
# ╟─017e316d-fb17-4464-a123-aa0071d7b0be
# ╟─1068f775-fde6-41d7-9aa6-5c57e0eaaa77
# ╟─99d05ae2-3e06-41d0-b5d4-7b445d497ad1
# ╟─108dc8da-4b6a-49d1-8dd4-5ecd22c542a3
# ╟─df8ecdb9-bbaf-4e16-9f8c-262e50f9bd1c
# ╟─6ab25ebb-99bf-490d-bd92-4b8e0036426d
# ╟─30319bd0-e478-4f9d-9c48-275b9ba9e44a
# ╟─7c14ced9-4863-4315-b2e4-cd905e462b79
# ╟─396dc79a-824f-4a8e-9b0e-e5aa250f9cdd
# ╟─eedffba5-fa2d-4c68-8a4e-f25a1e120ad0
# ╟─118501bb-51d3-471b-9414-09285b75f0aa
# ╟─cc139ded-19c6-4d71-bb36-5ca5e0e57ea4
# ╟─dae123ab-a366-4a85-a852-c8c1c87152fa
# ╟─36a9bf9e-ac45-4aac-a431-a8434352aa2e
# ╟─362f0a6f-a92f-489c-a499-6c4cbb12338f
# ╟─7cf34ea2-72f3-4fc9-9bd6-0803b4684102
# ╟─742aca52-5bc4-455c-bd1e-2e88a6d7a043
# ╟─e46d78e1-243a-4b4f-9112-d324364d84ae
# ╟─42487db3-df5d-4d1e-afda-9ec1ebbf4939
# ╟─1bb2c077-27f1-47c0-978a-bccd8df1b487
# ╟─d3076cdb-2550-42bc-b2c1-0c6b303432af
# ╟─b3e1f838-ca23-409b-afc3-2ca42fb09d8d
# ╟─4b68b602-31aa-455f-a409-6afb9405e2cf
# ╟─a26898e0-0f90-45b5-b789-397371c9ba65
# ╟─d08fad11-d915-4f2f-a9f8-6f42e2a8da79
# ╟─2add91dd-4e6c-4201-965b-680eb5f529ec
# ╟─feb7b6b2-e0cf-48cc-bde8-5c8649fdb57b
# ╟─39c79294-3abd-4b1b-9668-b5bc9c0c7c66
# ╟─826cfc53-5797-476a-a185-4bee6d4b357c
# ╟─889c445a-1a62-4467-96a3-3f0974091068
# ╟─d1f90c93-760e-472d-ab72-4c6c0a8cb3f0
# ╟─ea54d534-c6d7-4de4-a55f-a02c9266bec1
# ╟─4e1655d7-a0e5-40fd-b89f-4105d3fd300c
# ╟─05b7bc32-f94d-42f5-ae63-91391da72ca4
# ╟─ca507a8c-e4ba-4498-8a49-0fddac4c7209
# ╟─05849508-ceec-4f3f-80c2-dad48921b0b0
# ╟─efc29c6f-06ec-483e-b243-5c4cd178453b
# ╟─2d351e50-6fc5-4362-bd4b-a563e71929b3
# ╟─d57b4627-d66d-446c-a9ad-2e9ea42954d8
# ╟─79acf8f3-f34b-479d-8fbb-4cfba272865b
# ╟─26f7d04b-63df-4011-8284-af82913a0e01
# ╟─c377f410-c7a8-4ae4-a901-c7e11066f8cc
# ╟─0751712c-9870-46b0-83bc-93093cd0ce0e
# ╟─96700860-baf9-4324-96df-1f54acdee690
# ╟─9a7a19ce-1cd7-47e1-9fc5-f8689b0ff5fd
# ╟─343aadc6-d64d-4c85-92f8-9787d6af549a
# ╟─b868c935-c8f8-4d54-9cdc-fa9c2001750a
# ╟─bc02e2d7-9144-4b02-9d4d-18677c69f072
# ╟─e383ae38-a6e2-4c7d-9de5-5040e41259f0
# ╟─9f39ee00-2354-4241-87e6-8241b5b64748
# ╟─162a9893-3284-43d9-874e-3d2da83de481
# ╟─7dda28f9-d181-4535-ac9d-23dce03579dc
# ╟─8cbe782a-be10-4134-966a-0432d50ef817
# ╟─6fcbc28c-a73f-42b2-a324-6a028210a7c4
# ╟─9450e9c6-3f97-4e12-812b-a16d6a2591c3
# ╟─9a903024-378d-48b1-8aaf-33e9ca846b62
# ╟─e00a88c6-30f7-48e4-8f8a-ae46de9b4022
# ╟─6b546815-890e-4cab-9435-f036491c2a3f
# ╟─e65e9cd4-b085-4fb3-b85a-267f94dde8c3
# ╠═3ac30596-2ff2-4005-9ada-328c3000bdf7
# ╟─d6607daf-ff39-47ce-b6c9-ff56c79ff69c
# ╟─356b78ed-4e24-41dd-b65f-ec4f39ddb20e
# ╟─a63e14fe-e7db-4195-97f4-d1195aeffcaa
# ╟─d89b4f6d-fef7-4cd5-a570-d36148bec2b0
# ╟─ce287603-54eb-42ed-8f72-1769f560c68e
# ╟─12d76fc1-5856-434e-aeca-69e78d0d0903
# ╟─28b9e358-75a9-4ede-a08e-724c4b21b4e6
# ╟─77a9b72d-bb4f-40ba-ab75-c4c2ca97a1ad
# ╟─af0a79aa-5cf7-45ad-8680-0eeb953df369
# ╟─9a8df83a-daba-4274-86d2-c54c9e38ed2d
# ╟─1bebdd41-f2c5-4576-8100-c331e2d0164b
# ╟─f927c000-2489-401e-a39b-554d56162099
# ╟─9f510483-f0eb-4e39-89bd-321f7b7931d4
# ╟─dfa06187-b6f5-4548-bc6d-39ec9ffe7098
# ╟─b266bff3-1990-4ded-b7f4-a1f0d8e622fe
# ╟─447920f6-9120-47e0-a46c-0a217bdfc1af
# ╟─1cd56567-aa5d-489e-a9b5-8f65d7df810b
# ╟─3746f3eb-c4d8-4461-ad53-c9f7bb04f385
# ╟─b8acea39-63e8-45fa-8214-eb8e6f13ff96
# ╟─200d1770-94aa-4780-8e13-a5b268236cec
# ╟─f0ce410f-d502-43af-8eed-a2e06aa0492e
# ╟─b3fb3115-9c50-4bef-bdf5-28c9f424d331
# ╟─53ddfdbb-3e5b-4b29-abfd-8b86ef46529d
# ╟─d5fc9ba7-376b-4322-a744-2c960d3e649e
# ╟─b5107032-e1a0-42ed-9618-21e8228b2074
# ╟─e5c83d3d-d793-46c3-8f58-8ed5cdd2a909
# ╟─0bddc2a4-e177-48fc-b719-590fb9bfa51d
# ╟─90a75f2b-f1a3-4cd4-82ff-fbbd28d85e46
# ╟─5e4eb8a8-b5b4-4fd6-b98c-319b46293ef9
# ╟─d4d13cb6-2162-4ac3-ac2f-8837c1084e53
# ╠═4e4a8aec-cb96-41b1-b5da-c9510e0fe09e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
