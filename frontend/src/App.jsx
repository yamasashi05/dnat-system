import { useState, useEffect, useCallback, useRef } from "react";

const API = "";

// ─── DNAT Logo (base64) ──────────────────────────────────────
const LOGO_B64 = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAUFBQUFBQUGBgUICAcICAsKCQkKCxEMDQwNDBEaEBMQEBMQGhcbFhUWGxcpIBwcICkvJyUnLzkzMzlHREddXX0BBQUFBQUFBQYGBQgIBwgICwoJCQoLEQwNDA0MERoQExAQExAaFxsWFRYbFykgHBwgKS8nJScvOTMzOUdER11dff/CABEIAdoB2gMBIgACEQEDEQH/xAAzAAEAAgMBAQAAAAAAAAAAAAAABAUBAwYCBwEBAAMBAQEAAAAAAAAAAAAAAAMEBQIBBv/aAAwDAQACEAMQAAAC7IAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAw8yq4ncF+oJfq0Ec4PQAAAAAAAAAAAAAAAAAAABS9RS4sVPRnWFBnzvo0aTXvA6UtlSTVMCegD2Td83eQXZAhuAAAAAAAAAAAAAAAAAAAMZhOIUTK3ls43e+aWcPPVxTZ4m6JFlVtGDVXlHPSwJqgeFtU3UVmUINEAAAAAAAAAAAAAAAAABhW1+9kyp2Z83uu6CJuZkG6euZINT0kHqOpFmh6uaXPE3RUtjIr3ecWESxQ1Nko0XuM19AOZQAAAAAAAAAAAAAAAAGM1lfvGnLCuDZ422Hn1v0gn5Ag1XRwpatSLFDNxTeo5uhR5FbRB6D0AAAAAAAAAAAAAAAABhW1+2jLDuDZ4zY59bdMLXAAAEGp6SDLVqhPQzcU2eZuiRpNXRB0AAAAAAAAAAAAAAAAIcXunRjOBeGzlmyx73KYxZ4zHiaMyxP91uYO7lVWelX9CzwBBqekgy1aoT0F1SbOJ+gefVbRB6AAAAAAAAAAAAAAArLOvpyRmM4d73Z1M/SrShrVkGdVUpdYxLoCRHzNHcD6GiHoHkCqlxbObgSRX27XspawOgAAAAAAAAAAAAAAGvY5UyyrsK7gV5J8qmn61SVVWsGTyIMS6AziRNHYj6GiApbiu6grhczUrzdQ2vQgvgAAAAAAAAAAAAAAAAI8hH7T4sa/Et4FeSdJqJ+rVj6LjT57Wp3uDuFZes6EAxZ4VzRk2fdnU7OOvcW597mbjJzMD0AAAAAAAAAAAAAAAAABHkI/afFjX4tvAqyz5VNP16koaMIx4VrTk2QzrLbizv1s5NisHoAAAAAAAAAAAAAAAAAAABHkI/afFlXYlvBivLYSqadrVJVbnRB2GfZbcWd+u9GxVD0AAAAAAAAAAAAAAAAAAAAAAjyEftPixr8S3gVpQG3FnfgejYqh6AAAAAAAAAAAAAAAAAAAAAAAAaN7j2nxc6M2et3TtvXmMmlAHoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaja5Ade5CadE8+gAc8dCo7wAOQ6o2gAOZ3HQAAKKtOvcgOvchsOrAAAAAAAAAAAAAjSYx8v7Ljfqxz1J34+ZfSOAtDsAOA7/gCn+g8hAPqiFNPkv0/wCYfTyWBHkckcr7uI59A2cv1ABVQejHB1/S0Z0HvoAAAAAAAAAAAAAAjSYx8u+sfJ/rB6ByNdrsTsgOA7/gC38bOnPmX0XjoJWfT/mH08lgfLuz4Q+hauTwavp3yfui+ABzFHeUZ9DAAAAAAAAAAAAAAjSdZ8p7mtFpQyppyv0n3sAHAd/zZ46epth87+iaj5X9O5jrDceT59a6euMto5Om+g8gdm1bQDmKPra46cAAAAAAAAAAAAAAB41Egjkgjkh49g0G9FkHp59A8HtGkgBq8m9jIYjEoA8npFEoAAAAAAAAAAAADGfBWWEWwKzOBLgzqwu4W+rPVxS3JWWUGwK716jHvG3SWOyHMAKyfWzSLK91BZR7OlLrmOmgFhXxpJ4sIk4AAAAAAAAAAAAAAjaLAa9gao80aNnsPHsefQecew0bxCmgBGxKDVtCBPHjPoPHsePYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf/8QAAv/aAAwDAQACAAMAAAAh88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888896w1888888888888888888888hTv28598Q88888888888888888888/wC6t9vqvf6/PPPP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PPPPPLCoz/3mm/PPvOfvPPPPPPPPPPPPPPPKVGPInfX/ADz3sFbzzzzzzzzzzzzzzzzzT1a7331fqIIVzzzzzzzzzzzzzzzzzy53lR73f2bSr7zzzzzzzzzzzzzzzzzzy4D9rz9Pzt/zzzzzzzzzzzzzzzzzzzzy4flmfyT/AM8888888888888888888888+n08r9888888888888888888888888880y988888888888888888888888888888888888888888888888884w08888408848888088888888888888UIQ88cw888M08sA888888888888888A4U88Es88k0M88V888888888888888g0c88cs04MMAc8V8888888888888888w48w48008000088888888888888880YcYAwgoc8wQ4QMk88888888888888c8M88scMc8888MMs8888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888/8QAMhEAAQMDAgMIAQIHAQAAAAAAAgEDBAAFEQYSITFBEBMUIzJAQlEiYXEgJENwgIGhov/aAAgBAgEBPwD+xbdufMcqmKctshsd2MpSoqe2jxykFhKC3R05jT9tYMcNptOjAmyUSTj2WtgTU3C6cqSlq6MCCg4PXn7UEQiRKYZBgEQacdBvG5cZoT6pUyJ4kVP5JRgTZKJJxq1GmxQ7bsqI2Ce0vd9j2uOiqfnH6RqyaxdaluDJPcDzmf2q3XUXGhUjyCp+NSpJSDz0TlUKZ3ZIJ8U6UiifpWpkPxAqXyptx2E6uUpudHcHO/FOTY4DnfmpMhX3M9E5ezvl8j2qMaqfnfEOq1cLk/cJBuvLxqBBkXF9GY7eSqx287dAbZNxSLrntgzO7JBNeHRa3fVSonieOMmtGBtEokmF9pfL5HtUc1U/N6DVxuT099Xnlyq1Bt8m5Pi2wGc1YLCxamd3d4eP1fwwpvdfgfFF5LScMYqXFSSmfnRgTZKJJx9ld7gNshOyF6cquFweuD5POllagwX7i+LLQ8asFgZtrAETfm044LTZmS4EUytXrXSMOd1Cb5ZydMa6uwnueIFCrDqBi8tcE2uomVHtgze7/A+S8lpFzU6ILwKQJ+VKmFx7HWjZHZjUfiSUtaJm24XBZNPP6F2a0nlEt3diuFcpeyxzTg3CO6BYXcIf6oC3gJfadtvB1Gvz/wBUq4Rac9Zfv7GVGblsOMuJkSTFX+xv2x9V2+V8SoDNpxHGnVAv0rSup25YLGkH5g8lrWcApltV0Ez3Sbqx99lkhOyrlGAE+iVaAdgCP0lOOA0KmZYRKtsiM6aHuQk6UipU+dt8tvn9+znw2J0c2ng3CtX+wPWl5Vxlpc7TxQETRIbZYL7rTmo2J7Pg5xcV/wC1d9Gd+ROwiFRLkNR9C3VSwZAgLzqw6fYs7acdzvVaddBkFM1wKVqrVKSSchxT8pPUaVpjUzsF/unx3sF8uo1GuZnGTZxQk4LSrn2k6CxPYJl4citX7Tz1pdJf6Px4UDpMuIYcFrS2qW5I+GkF+Y9exxwGgIzJBFOarWp9T+IcOLFPLI+oqVd5Kv3Wl9LnMJJMnItDxRKbAWgEBTApy9tNgsT2CZeHIrWoNPvWmT0VkvTjpQErTyOgWFStM6raebJiWe1Q9K5rVep/FZixT8vqVcXFrTGlTluBLlD3bQf9ptsGgEATApy9xOgsT2CZeHIrV908/aX+e5kvSVIqpnFIikv61pjTDk3EiUCgAf8AqmmhZbBsEwIphPdTYMe4Mqy+G4anaBdVz+VdwFWzQ3dOI7Ke3U02LLYNimEFMJ/jt//EADIRAAIBAwIFAwIDCQEAAAAAAAECAwAEBRESIiMxQEEGEFEhMhNScBQgNEJgYXFygqL/2gAIAQMBAT8A/QpmCgknQCrj1BaQNtVS9Qeo7OVtrqyfHmlZXUMp1B7bIZKKxjJJBf4qbPZCVtVl21YeobpHCztvSre4iuolkjbVT7epL14o1gjOm4ak11rcV6GvTOQaVDbSHi+rDtbuV4IJJEXcwFX1zLdSs8hqGGSc7Y11NSK8T7WFYnJSWUgBbl1b3EV1Eskbaqa9ToyXSEjhdfof8UK6mvTUTPflx0RND2lnaPdy7AdB5NXmIjEOsX3CszgDI+6CPa5+8VjMVFYxr9OOs3hhcI08I5lPuRirCsRk5LOQAty6uoIMxZcBB/KauMVe2zAPD16VaYy7mk0EVYywSwg2gcTdezs7OS8k2L08mra3S2TatXE8dvGXc1dT/tEpfbp75nCpcK80Kc3yKfdGxVlrEZSSzk0J5dQTxXUayRkFTWgHjs7OzkvJAqjh8mre3WBdqiridLaMu7VeXsl03EeH93NYVJ1aeFOZ5FSK0TFWFYnJyWcgBbl1BPFcxrJG2qnsreEzyqg81bW6W6bVqa5SBCzVeXj3LH8tAakCrTDF13TnT4FPg7fQbSRV5ZSWjAN0PvmsKk6tNCnMp0eFtrCsJkntp1Vjy6R1kUMvQ9jiGVb2PdWlZi3mZRKBwD2xMKy3I3ePYjWr2FZIHDD3ZlUFmOgFZq4gmu3/AAR9v81QqxkGlWn8NB/oOxRyjBl6irHIpcIqseZTgspXSsjjnty0ijVKxMyxXI3ea1rWr6ZY4HLUevtnI7l7YfgnTTXdTqdf71g8TJOUnl4Y1/8AXZxyNE4ZTVhkluVCt99SIJFKsKyOPaDnIOCrbMtGu2VS3xRzlso4QzGru+luzxdPigCx0FY3GbSJZevgVk8asqb1A3eamwNo94Z2H/NIqooVRoB2kUrxOHU6EVYX6XCBWPMoqpGjCsjjWh1mQcHsAWIAFY3GGMiSXr4FAisnk02mKPqaJ1JJ7aKV4nDIdCKsL9LpArHmU0QdSpFX+MkjdniTVKxmMZWEso+vgURWSyaIuyI6vRJYkk9xFI0TBlNWGQW5QKx5laGgdKyeTREMcR1Y0zFiST3UcjRMGU1DnCF0lj1q5zTSLtiTb8miSxJP9egfrz//xABAEAABAgIFCAcHAgUFAQAAAAABAAIDERASIDFBBBQhIjJQUWFiY3GBkaGxEzAzQEJykiNSc5CywdE0U2BwguH/2gAIAQEACD8C/kgk6Ewd69oUHlP0oHdzGzQIRE0LQOqLJ2d2tOrYF6xsTt8N1FDZtBG+npbxbdiLDbAvRvoGGm3x3SLkEwdoowQTRrWBejfQBqmzhjukXUYIIHtQpbtWBejeimeCLCqhT9CAkN0fTYF1pu1YF6N+7MLGCFtu1YF6N+6sLGHum32Asd0YWMEPdsvsC9G/cwusYIWJqXuG32AjfuTxsYWcLF4QtN2rAQ3jxti/dZv91ztjZsctyGwb/fjZsfSNy4o2Df70JnhTgmjc2Nk30C6xhZF1LO8LBAaN0Yo2DfRK3hYCA3VjZN9vCxhu0X2TfZw3njZN9OFjBDeAvRsFYb3x9xhvUWsN74o03BDfNVS/7fAnUYXS7FmbPyWZs/JZmz8lFguZzvUKIHN5WRk7XSA0zleokMQn/SJ308AszZ+aqyrsDpWYeTteGaK1ZPghkxoM7LYAfNlac1mbPyWZs/JZm38lmbfyWaN1jLa+c6l/pRnETWaDgm5TE75LREh8RgoR+5uBTLj5WOi1NMiLin6Izdrnzo6Jo6ptjgNHaryT5pu0x00257Z2HxntIbLQs5i+SZFc6uTtck5xaHT0hZ1F8lnEXVM8PnOpf6UdW30pZ8N4rNRO0Kw7rHRamfEhnQOIUN1V7ShoeNtvBdE0dU2w3DXejdBFbvwQGo/Wb3pxu1mdlrpOXb6fPdS/0o6tvpT0XIftdY6LV0mqAz+IB6qH/wChxChnQWnuo6ptLrmiad9bkRrRdf8AwhtQtPcUPpOnsTbiJ2ek5dvp891L/Sjq2+lLNhgqtWDG1e82Oi1c20Qh+i43ftKvhvEnNo6ptI2o3oKBlTgAjlbiDoNDjrQvSz0nLt9Pnupf6UFsTQ0C5CHEPdJMb7KEb+JUJszxwHamd54mx0Wrm2h7ZtcJEK+E7YP9qOqbSDqM1W9yisDm7LZhZrD/ABCzWH+IUKGGjZdIInUdqu77PScu30+eBkXsLfFZxD81nEPzWcQ/NR8oLuTdCgww1tlsVgBAvUR7TXIupiDQfIrOIcu9EzqMDfCiGQHlshNZxD80PpGk0uucFnEPzUVwL2iRIsMe1tQm/mnxmENnd/xuLFawczJMylhPCaiODW8Sm5VDJ4TodlTARfpUKKHyvlQxwc3iFFjsa7gSs7h+KhxA5oxCrj2cp1kE9wEzLxUWK1k7poZVDJPOxFjtYeBUPKWOccAUHazbxwnQ14IBkT2LO4fioTw5vEJjw4cqA8FmnWw0LO4fihlUOZu0/OG5jS7wWVND40QTE9IYDgFEgMPdpXTh+qiCFsmXGfJRduoJqIGTzl9//wBUMN51VD+LGPs2d+Kn+m9vtIX906G0nmEYbdERuHJNaBqm5OGq6HIp518nfU7sF9GTCu77jcnSlXff2ICFPC6xEqyzXH7k0Q58pL6I36T+3BN29ln3G5cIZn2pzYc6gvkmAS5Jk3QnRH+3h9+0EwzaRoKP7on9RQhNGgYc17Jnh85+9hb4p2iNBFSIzhJEyCvFdnqsnhNZHYazHc+audc9vByjQGvdnD9JUGEGA3yUGNUZk+o0yrTcb1nQiOgGuG1AO1M2XCYXWN9F0Sugj8OI32cTtGyonxI7vaO71EbWaXvmO5NyVgLdINiNDDwMlnp+5Qsna13FYkavaLkRIZOytF/iXSXRKfkzC4s0lQmBreAXWP8AVD/RxHaR/tO/wuk/+orkPVcvnXNIiC57TVcokSNFlcHvJCfs6LuVDNBibXDQhGjtrOrGrEI0lCLEdW/e6t6qGNWiHOqm3xDN1DNltyiibTLyoeXAsmQWmV6zjKL8YpsF8Rr6tWbHVdCEeOZYOiEihjZe0fWcuKbHygDgIpVd7vvdWTLpk+KcJg3hQxJjZy70/Zdf/Is//8QALRABAAIBAgQGAQQDAQEAAAAAAQARITFBECBRYVBxgZGh8NFAscHxMJDhYHD/2gAIAQEAAT8h/wBIIUAbzQF3Rm30MRC7XduVQg6kDirt4aTloglnmNolwDymh/xndu5ucrgjgyNHK28HPaDefC70uIzRV9+RK6EEC0dTkVBRcc7CLqrwpwlBHDp+7mLrSTQBvOPwnP8AJPCgtrHqSuJqGDeYKbmvE09DRholHhSMkfDnpnqvwivbpCkMcd4Zd0zPJHDoU6sIBQTO8s6xFImTiIehPUQ4I7mMPeVyEjbqgADQ8HC5jsmDw6i3EuSsSG6ReEDlQcTufd3mRRMnEQ9CCCUdSLBwy9XZ1Mdr2NwbR/SZ88hDIOx4Pr2IAv8AlDjvndzFY+7vESJScRT0JoY4aJR4QB7REh/3yfIjK0Uc5lH8oikSk4gnQQCNR1PCQHaKqchybNYdJp/hMoeXrEUiZOI96SWY4eDmVWYQ0vvyVws3MIAoND/Hozy9YikSk4i3oQk0GvgpG2MlORgXqggKDioaxWsnoTv4jV1AaHmMIV++IpEpOJd6SXIo6nglXc+HI/Y6w0BxBFaI7Q1yFfcIGTmAoflEUiUnHYEcnUgqLEs8DeR2ONSuoKAoOTRG+vNq7nVpgL7PJkHp4HiGicbrM1n+XF0mSd+Z0nS00cqhWgjDCPnkRnU8DYz2itDPHIiNMwnx+eDpA2+vMFE6zRyLQrLg/lyITP5PBTChLNBniKNmsrX/AJzaKJTz5ssMHIJYSSya4d38OPRp1YHqB4MIshWiZ42iJtMZ4PIYjZC8hMxXVBY0OJhWIq/6y5Gm5MNmsPf+QnTp1ZUEGh4OwzYQrQzxMSv5HzmIvtPlidxit1fnAOIm1oiND+fG1mm8AOQwygDp4UYshWicc7NPWdhvnmAq6RqjkMSyKAo8MAwI0TPG0RGVrPz5BLdIrjyclZNDVgwCjw4gpiHQnEVCOZhN+fASq4ilclTHmhoKPEC9AMRoM8RRscw6HSEdUcmkGm8OgeJCLIRonPjHqg0DG3ih7hFUTl+cIXA8Wq2aN4tR4599SCAoPGA6S5YukVskA/8Ary2LzSrpc/tP4n95/E/sP4hfr8tYlfbrlvVou4Uezisf98e8o+0tP5H4jO25hdXyrzLIi3faLe/VXtNuXUk0V3qf3Gf2D8T+5z+xfiJAwb23/W4Li+hHWLQHUStquxEAlLXX8xMQfd0ejNJ9ydXR5PoOkS4oQ1Els6eH7XD6jpNCfX9ORnOcfq9J3vuymKQA9ImNk5GLAHWvnhVg2dw2TK/Nq4Ln9b+MFaIken0/W4fE4xIBEsdSDFVC6XtFw56/q5PoOkfvHerGkSLZf8fODacDqPxPqOk0J9f05LUMD8EqjvHfGAL8sJbkr9Zqc30/Q8Alh8Dki86/mJ7sfKuT6DpMpHv9+3xELNH070sHXRuq0eA+v6cW0pqexGGyjXQ2IlTPbyjE+f8AlR4f3W74j6WIPZ5fp+h4AbD4HGLSJ5ZG61qx1zSnkfoOk+26RBESxjazp6rbyglrn8o7w0CfX9ONn81PzSqgV4AGmCHHhB3Hbhrq9Hd6cv0/Q8ANg5HylvC9XSRAtdIHX2Bs+7Fz7mx6qZDKz1jV5PoOk+26cAPXg0SIQFb+VKn1/Tjmb/JH3mkhmT3XiMMC+NdRnRmDFfTjXJyfb9P15itBy7UriJWbNcIjT7Ffm4KLtjfzd+Uk7YWvBLUKjy8bh2k77CeUSpysXByk0m9OC1wLoF3nn8PNfrC6vHUhZfR2YyQIk6E1yWe3ueztMnjxa8n/AJsD1hKPdB77MFCNUoIIVNAbeDzLoOlg6KrZ3rwyFxBLLMMwmocJp4X1oMNYVD9porrASWJYkeRRK9dBBaA0Tq6jXwoDe8j8oWLWJoaKyGDmaetsXweVADgdWeF8zKSyzEp+qlq8nA19ll2HgVI5KHX+s17Yei5iSqpoKNMp1w9CQBdKPSswwbEO3hvKM3f9fWMF2N3tGN3yP4hzSfZdXoIRC1B1MGY0VVgvzDBZSs4kYBoCjTtLdyQ7NxgS53vrftK4R8/Yw+WsvLe2z3zcOaDVyBYdhjV+aexDW+IQWj297/iPqxh64YrvW96stfedSnUtcBxt+mviB1eIZoMe+bwE98GjCAWNlyYVawTbLFmoTH9ZRrT7cqUnls1WN+THwA1VqJYpO+ImH8TQ2bdQyvFD1BakxWF3qiIdsb2Iy33mgzL6aRfanahos6kSKxt58B/pOk+l3mEVvuif2h/Iq7baehBu2t0ZWXWBkeQpToNjvggvEDrmB1ILpmXvLxKS+zGs+j6Ql7lLtYFG1TSzBfuffBknqCzc74Khswsvs+mfAfrdV4je4TQI/gahosVhhrs4Bw063k7q6xu0sBO44lJbBq0rpFXYK5yqtqxBEdGAqBVBbq84gFNbJuFYhMaInvCzQ6LmiXwUk81wKwRwEpLKVqSw30GkmOQqIZD1KaiMV3YXmPC889SYK+gR9YZP6AhDiVbtF7sq2msdVbAXjpNEZpLgLeq4bahVMb3AoBof6K//xAAtEAEAAgEDAwMEAgEFAQAAAAABABEhMUFRECBhUHHwQIGRobHxwTBgkNHhcP/aAAgBAQABPxD/AIQToLamiXqhxYfYnsZRIPxPvCQJ4AAVHuWXlfprBIJfwzRYlY8Kzgge3NoUqDcdorGZ8tA3TV7R3IQdvIIJAiJY+loCAMsGI1HMmvV++hZp5gnZpgneL6PaxNXvyBj0ofJrVwQuJcco3hCPRIiWAYgB1DfyMPeg+Bj0q5HLDXoVCGNftlNiBdESg7PV7KLhovgnQgneDaWL/SIolCVWWsOF5YDQgzvH8udx5Om6lHmg/wAVAQycAyNJQsJSPS4vFGGAkA4H+SJYjLfjHyNuivMqVKhUo/4IDVAAejt0olNv8uugdMv955lasCy32H+SGbBt1IqQWDaRKEIieToR/KMMCJgJBiJJTCvw+vZlHDhGH7kt8R5krxW3cn/UMECgFejkFKCLANAQKh0N2Dm7qnw5rKdkUjDotlGGG3o1Ongng9ITq0JgpkSulXLAkDNB07xWhykv2RSMvolFMI1C9C9JHS4Mfo0/b0OmkKq3Nw8YDQ/0TThG9h4j9hKRg9FAq1h/lx6PQACPyAHoqVATbN1gwRUH+m6qgtUYMf8AqpHq+FGGO3RYeiscAROgHLz2VzDd2VAtSVMOPdIT8/l5hggncC8TIbIlbAR1HcYMYzlUPBHfomiHZcAh0GqVgfmVlg60UAVjtB8b9mo1NzfkloO+4x4NiH7IpHokz7VUa7hKMjJ4fQ7+FIz0BsjeHqBg7Fb+hV21GsusA895fJkOAP8APEWutslSt+z6G1dgEOgmBpNGGSkd+rWjxWSn4O57jAL7TPtFjEqsQt0SQ566WqH0O1aXr4Ma1Qonk6jQA33imi3tjCa0Ihq07hw1JNLsBgACqxIwLQnZz+EV2RtAAA9EGMAwxegOoJEDhmlgbxrAq8O4w6jD3gUB1SFoNWFCXeUvi0fvz6lzKz/qIdgVejPToSrsOosKch4YZoD+4mAUUjPEBJddmoX11w16DrooArLHoHUYs5agHUN6yh5wcKHf7vxChFoPSL+sJVwOpLiRaxSWr0NHhvHjmXWOqlTP/wBcAZ20GgFHVqAdVibE/iElS9GWiPwCgcC0BR6U1OhoyqsmH3OtimgRN0p201D3FZoRMyF/PYftBy8w+wlB6YyACYYlYDk6lUiZE1GCFSmOw5QBqsVix1cvZoQkHj9OBzolKZJUSIAA2JKngkDcpoCKxYHTns4gQfAdA9QXYDBKgOlQUgGRirPReQl9U5c9hUKOqVpg9SWnQldZJXdswdZMEDA9UYFRlTZJfYNAoapTWD1YlOixF6J56t1vKM/iCxBQcHrCI43GaIGU5DDP/rwVQ90Wq9Q//ng9hRBTJI9l7tHTkrEEXPApeMKHXXIKeLQ0WEnZgGo0V3V9tlhuuukCHP7Ej26OrFqYq7SOd1ei6MHQf1nzXOZlPDs1GJf8EZW9DbMUdmJ08062aQzOETHDnrbu+Y7Z2qnRWiIx8MXhHT+P5dwlG0NPaMqApd5f81iJu0fO1gRQM4UyfZ7BXar3ecJ/UwPaLFSh2IfCsdW/C5/7kZA3wovt+s/Nc5+xny3DodYCIWI7MaKDsy0Y/CXti7U9xPyupEFf7Abrc+NCMbkws5i+H5dwlJ1PuhwWGSt9wwQVWA9uA7iR3hCv2f5vrvmuc/dz4bh1J5sR+VLtk5In4VW1P5gzXIygSPk5flF9kp2EOaAbZfxJ7Ns9iXC58LwIxjV+bgnQ/aeXB+8HJN7cbHulfsfzfXfNc5+znwXDooFWg1Zx93S9Rn3D43az/N8oaYCIliMY6vFmPrE+VlEOITDsEt84nxZpcGYTP7IAKAiXnnEHTBWo3FsLz7OfdK/Y/m+u+a5w0PJi+7+KWZBtcUZhXUYePCj+AmL+BCWDi7dde9s/zfLouTA9oiKsn7dKGJ+fh396br5DivVSSULtmqmVcCniAQRLE7M/hYz4Pl9dphITT2hz8f0sCkDyCR6e3/mUkIYw58tZdpfnLzSS1t7YD1rbtdgflQBV6WBNP/c7os6AnRJQKtUeT8mAz4oFXr6h8lF3bb7M/wDKQvLrF5eex90r1gghrpUd/wDtsSN2g4vBcAshYAfbQx8PhnlEUMFyHx0T10sIR49CgDkdLfSF2VCzhJpruwIf0yIe5C0AUYhUws+m1AjTkLEciR4jK0LUHljfWomxaELsc5b2FfL8UwsVUNYLr8m6K6PJ0DC6N0o+E/pkMopbwwgYFEB6R6MhQQYBqL4Sf1KEo6UZX1mRfyaSUdKeQMjYRH4CweaSRkUHjhk0i3Bppnr5R/sqav2iFaPF0GGGeogE8XKI4q3/AESTTpV3kT44sw6PIYH1EpBDGMtG54AhPuadBGzEur9fZ+66cH7sbgE7TgjgIs1GdV4VW/ZlROhcMg41p97rVGBpdRgc/wAuYy0GFwvqI5VXbNT+7jKImf39cr93IEX3kYR8rpgOHTuQxInrBgtRIGEZCltKqIaIFA0Q+sVcAnysBhgMDa14iCjixgHuyyb2Eg/kPipYTiGjZbx3f2Y1qeo0JCLVKoLdlaWPa2P+RH8bGmTX2e7xIqM+U5T5nnMqdkMJsobEt1n9OGrm8NAgeGjaGCIJ1oQyeykAgrjBaEaICb1tX2EbPF86b+1j5bnC0r+kQnHgUF2wSOfzpWk23vGUgDK/KPSY/McfWi2+gwTUN+scMNhOKJD7FdDg1Uppn8xlnorLtEFACKlm1J5ivLrVvIbqsBAQRHcZe2P/AC7HhDPbPsNIjaav7PYVL/gYtDNplEyAgAAAKAjYnnvYqAIpuTuKL2Vv8VbfI1lxZAAy/Op6D2aXkp+gsoVB4vXtjBEbxzhYhiE4rbX7mJ4aRcBU6FeC1/thM1ArUAUw9FAB4P8Agr//2Q==";

// ─── Auth ────────────────────────────────────────────────────
const USERS = {
  manager: { password: "dnat@2026", role: "manager", name: "ผู้บริหาร", icon: "👑" },
  staff:   { password: "dnat1234",  role: "staff",   name: "พนักงาน",  icon: "👤" },
};

// ─── Theme Colors (DNAT Brand) ───────────────────────────────
const C = {
  blue:    "#3BB8D8",
  yellow:  "#F5C518",
  dark:    "#0D1117",
  card:    "#161B22",
  border:  "#21262D",
  border2: "#30363D",
  text:    "#E6EDF3",
  muted:   "#7D8590",
  muted2:  "#484F58",
};

// ─── Icons ───────────────────────────────────────────────────
const Icon = {
  Box:     () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>,
  Check:   () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><path d="M20 6L9 17l-5-5"/></svg>,
  Alert:   () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>,
  Clock:   () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>,
  Search:  () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>,
  Plus:    () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>,
  Edit:    () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>,
  Trash:   () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>,
  Upload:  () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="16 16 12 12 8 16"/><line x1="12" y1="12" x2="12" y2="21"/><path d="M20.39 18.39A5 5 0 0 0 18 9h-1.26A8 8 0 1 0 3 16.3"/></svg>,
  Return:  () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><polyline points="1 4 1 10 7 10"/><path d="M3.51 15a9 9 0 1 0 .49-3.51"/></svg>,
  X:       () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>,
  Image:   () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="8.5" cy="8.5" r="1.5"/><polyline points="21 15 16 10 5 21"/></svg>,
  Eye:     () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>,
  EyeOff:  () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/></svg>,
  Logout:  () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>,
  User:    () => <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>,
};

const STATUS_COLOR = {
  "ปกติ":    { bg:"#0d2818", text:"#3fb950", border:"#238636" },
  "ชำรุด":   { bg:"#3d1c1c", text:"#f85149", border:"#da3633" },
  "ส่งซ่อม": { bg:"#2d1d0e", text:"#e3b341", border:"#9e6a03" },
};
const RETURN_COLOR = {
  "ยังไม่คืน": { bg:"#2d1d0e", text:"#e3b341", border:"#9e6a03" },
  "คืนแล้ว":   { bg:"#0d2818", text:"#3fb950", border:"#238636" },
  "เกินกำหนด": { bg:"#3d1c1c", text:"#f85149", border:"#da3633" },
};

// ─── Shared UI ───────────────────────────────────────────────
const Badge = ({ label, colorMap }) => {
  const c = colorMap?.[label] || { bg:"#21262d", text:C.muted, border:C.border2 };
  return <span style={{ background:c.bg, color:c.text, border:`1px solid ${c.border}`, fontSize:11, fontWeight:700, padding:"2px 8px", borderRadius:4, letterSpacing:"0.04em", display:"inline-block" }}>{label||"—"}</span>;
};

const Input = ({ style, ...props }) => (
  <input style={{ width:"100%", background:"#0D1117", border:`1px solid ${C.border2}`, borderRadius:8, padding:"10px 14px", color:C.text, fontSize:14, outline:"none", boxSizing:"border-box", fontFamily:"inherit", transition:"border .15s", ...style }}
    onFocus={e=>e.target.style.borderColor=C.blue} onBlur={e=>e.target.style.borderColor=C.border2} {...props} />
);
const Select = ({ children, style, ...props }) => (
  <select style={{ width:"100%", background:"#0D1117", border:`1px solid ${C.border2}`, borderRadius:8, padding:"10px 14px", color:C.text, fontSize:14, outline:"none", fontFamily:"inherit", cursor:"pointer", ...style }} {...props}>{children}</select>
);
const Field = ({ label, children }) => (
  <div style={{ marginBottom:16 }}>
    <label style={{ display:"block", fontSize:11, color:C.muted, fontWeight:700, marginBottom:6, letterSpacing:"0.08em", textTransform:"uppercase" }}>{label}</label>
    {children}
  </div>
);

const Modal = ({ open, onClose, title, children, width=640 }) => {
  if (!open) return null;
  return (
    <div style={{ position:"fixed", inset:0, zIndex:1000, display:"flex", alignItems:"center", justifyContent:"center", background:"rgba(0,0,0,0.8)", backdropFilter:"blur(6px)", padding:16 }}>
      <div style={{ background:C.card, border:`1px solid ${C.border2}`, borderRadius:14, width:"100%", maxWidth:width, maxHeight:"90vh", overflow:"auto", boxShadow:"0 24px 64px rgba(0,0,0,0.6)" }}>
        <div style={{ display:"flex", alignItems:"center", justifyContent:"space-between", padding:"18px 24px", borderBottom:`1px solid ${C.border}` }}>
          <h3 style={{ margin:0, color:C.text, fontSize:16, fontWeight:700 }}>{title}</h3>
          <button onClick={onClose} style={{ background:"none", border:"none", color:C.muted, cursor:"pointer", width:28, height:28, display:"flex", alignItems:"center", justifyContent:"center", borderRadius:6 }}>
            <div style={{ width:16, height:16 }}><Icon.X /></div>
          </button>
        </div>
        <div style={{ padding:24 }}>{children}</div>
      </div>
    </div>
  );
};

const KPICard = ({ label, value, sub, accent, icon: Ico }) => (
  <div style={{ background:C.card, border:`1px solid ${C.border}`, borderRadius:12, padding:"20px 22px", position:"relative", overflow:"hidden" }}>
    <div style={{ position:"absolute", top:0, left:0, right:0, height:3, background:`linear-gradient(90deg, ${accent}, transparent)` }} />
    <div style={{ display:"flex", alignItems:"flex-start", justifyContent:"space-between", gap:12 }}>
      <div>
        <div style={{ fontSize:32, fontWeight:900, color:accent, lineHeight:1, letterSpacing:"-0.03em" }}>{value??0}</div>
        <div style={{ fontSize:13, color:C.muted, marginTop:6, fontWeight:500 }}>{label}</div>
        {sub && <div style={{ fontSize:11, color:C.muted2, marginTop:3 }}>{sub}</div>}
      </div>
      <div style={{ width:42, height:42, borderRadius:10, background:`${accent}18`, display:"flex", alignItems:"center", justifyContent:"center", color:accent, flexShrink:0 }}>
        <div style={{ width:22, height:22 }}><Ico /></div>
      </div>
    </div>
  </div>
);

// ─── LOGIN PAGE ──────────────────────────────────────────────
const LoginPage = ({ onLogin }) => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [showPw, setShowPw]   = useState(false);
  const [error, setError]     = useState("");
  const [loading, setLoading] = useState(false);

  const handleLogin = () => {
    setLoading(true); setError("");
    setTimeout(() => {
      const user = USERS[username];
      if (user && user.password === password) {
        onLogin({ username, ...user });
      } else {
        setError("ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
        setLoading(false);
      }
    }, 400);
  };

  return (
    <div style={{ minHeight:"100vh", background:C.dark, display:"flex", alignItems:"center", justifyContent:"center", fontFamily:'"IBM Plex Sans Thai","IBM Plex Sans",system-ui,sans-serif', position:"relative", overflow:"hidden" }}>
      {/* Background decoration */}
      <div style={{ position:"absolute", top:-200, right:-200, width:600, height:600, borderRadius:"50%", background:`radial-gradient(circle, ${C.blue}10 0%, transparent 70%)`, pointerEvents:"none" }} />
      <div style={{ position:"absolute", bottom:-200, left:-200, width:500, height:500, borderRadius:"50%", background:`radial-gradient(circle, ${C.yellow}08 0%, transparent 70%)`, pointerEvents:"none" }} />

      <div style={{ width:"100%", maxWidth:420, padding:24 }}>
        {/* Logo */}
        <div style={{ textAlign:"center", marginBottom:36 }}>
          <img src={LOGO_B64} alt="DNAT" style={{ width:120, height:120, objectFit:"contain", marginBottom:16, filter:"drop-shadow(0 8px 24px rgba(59,184,216,0.2))" }} />
          <div style={{ fontSize:13, color:C.muted, letterSpacing:"0.15em", textTransform:"uppercase", fontWeight:600 }}>Equipment Management</div>
        </div>

        {/* Card */}
        <div style={{ background:C.card, border:`1px solid ${C.border2}`, borderRadius:16, padding:"32px 28px", boxShadow:"0 20px 60px rgba(0,0,0,0.5)" }}>
          <h2 style={{ margin:"0 0 24px", color:C.text, fontSize:20, fontWeight:800, textAlign:"center" }}>เข้าสู่ระบบ</h2>

          <Field label="ชื่อผู้ใช้">
            <div style={{ position:"relative" }}>
              <div style={{ position:"absolute", left:12, top:"50%", transform:"translateY(-50%)", width:16, height:16, color:C.muted }}><Icon.User /></div>
              <Input value={username} onChange={e=>setUsername(e.target.value)} placeholder="กรอก username" style={{ paddingLeft:38 }}
                onKeyDown={e=>e.key==="Enter"&&handleLogin()} />
            </div>
          </Field>

          <Field label="รหัสผ่าน">
            <div style={{ position:"relative" }}>
              <Input type={showPw?"text":"password"} value={password} onChange={e=>setPassword(e.target.value)}
                placeholder="กรอกรหัสผ่าน" style={{ paddingRight:44 }} onKeyDown={e=>e.key==="Enter"&&handleLogin()} />
              <button onClick={()=>setShowPw(!showPw)}
                style={{ position:"absolute", right:12, top:"50%", transform:"translateY(-50%)", background:"none", border:"none", color:C.muted, cursor:"pointer", width:20, height:20, padding:0, display:"flex", alignItems:"center", justifyContent:"center" }}>
                <div style={{ width:16, height:16 }}>{showPw?<Icon.EyeOff />:<Icon.Eye />}</div>
              </button>
            </div>
          </Field>

          {error && <div style={{ background:"#3d1c1c", border:"1px solid #da3633", borderRadius:8, padding:"10px 14px", color:"#f85149", fontSize:13, marginBottom:16, textAlign:"center" }}>{error}</div>}

          <button onClick={handleLogin} disabled={loading}
            style={{ width:"100%", padding:"13px", background:`linear-gradient(135deg, ${C.blue}, #2196a8)`, border:"none", color:"#fff", borderRadius:10, cursor:loading?"not-allowed":"pointer", fontSize:15, fontWeight:800, fontFamily:"inherit", letterSpacing:"0.02em", boxShadow:`0 4px 20px ${C.blue}40`, opacity:loading?0.7:1, transition:"all .2s" }}>
            {loading ? "กำลังเข้าสู่ระบบ..." : "เข้าสู่ระบบ"}
          </button>

          <div style={{ marginTop:16, textAlign:"center" }}>
            <span style={{ fontSize:11, color:C.muted2 }}>DNAT Equipment Management System</span>
          </div>
        </div>
      </div>
    </div>
  );
};

// ─── Equipment Form ──────────────────────────────────────────
const EquipmentForm = ({ initial, onSave, onClose }) => {
  const [form, setForm] = useState(initial || { code:"", name:"", category:"", team:"Other", status:"ปกติ", location:"", quantity:1, description:"", notes:"" });
  const [imageFile, setImageFile] = useState(null);
  const [saving, setSaving] = useState(false);
  const set = (k,v) => setForm(f=>({...f,[k]:v}));

  const handleSave = async () => {
    setSaving(true);
    try {
      let id = initial?.id;
      if (!id) {
        const r = await fetch(`${API}/equipment`,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify(form)});
        const d = await r.json(); id = d.data?.id;
      } else {
        await fetch(`${API}/equipment/${id}`,{method:"PUT",headers:{"Content-Type":"application/json"},body:JSON.stringify(form)});
      }
      if (imageFile && id) {
        const fd = new FormData(); fd.append("image", imageFile);
        await fetch(`${API}/equipment/${id}/image`,{method:"POST",body:fd});
      }
      onSave();
    } catch(e) { alert("Error: "+e.message); }
    setSaving(false);
  };

  return (
    <div>
      <div style={{ display:"grid", gridTemplateColumns:"1fr 1fr", gap:14 }}>
        <Field label="รหัสอุปกรณ์ *"><Input value={form.code} onChange={e=>set("code",e.target.value)} placeholder="A001" /></Field>
        <Field label="ชื่ออุปกรณ์ *"><Input value={form.name} onChange={e=>set("name",e.target.value)} placeholder="ชื่ออุปกรณ์" /></Field>
        <Field label="หมวดหมู่"><Input value={form.category||""} onChange={e=>set("category",e.target.value)} placeholder="เช่น ไฟฟ้า" /></Field>
        <Field label="ที่เก็บ"><Input value={form.location||""} onChange={e=>set("location",e.target.value)} placeholder="เช่น ชั้น A" /></Field>
        <Field label="ทีม"><Select value={form.team} onChange={e=>set("team",e.target.value)}>{["Production","Event","Other"].map(t=><option key={t}>{t}</option>)}</Select></Field>
        <Field label="สถานะ"><Select value={form.status} onChange={e=>set("status",e.target.value)}>{["ปกติ","ชำรุด","ส่งซ่อม"].map(s=><option key={s}>{s}</option>)}</Select></Field>
        <Field label="จำนวน"><Input type="number" min={1} value={form.quantity} onChange={e=>set("quantity",+e.target.value)} /></Field>
      </div>
      <Field label="รายละเอียดการเบิก / หมายเหตุ">
        <textarea value={form.description||""} onChange={e=>set("description",e.target.value)}
          style={{ width:"100%", background:"#0D1117", border:`1px solid ${C.border2}`, borderRadius:8, padding:"10px 14px", color:C.text, fontSize:13, fontFamily:"inherit", resize:"vertical", minHeight:80, outline:"none", boxSizing:"border-box" }} />
      </Field>
      <Field label="รูปภาพ">
        <div onClick={()=>document.getElementById("imgInput").click()}
          style={{ border:`2px dashed ${C.border2}`, borderRadius:8, padding:18, textAlign:"center", cursor:"pointer" }}>
          <input id="imgInput" type="file" accept="image/*" style={{ display:"none" }} onChange={e=>setImageFile(e.target.files[0])} />
          {imageFile
            ? <div style={{ color:"#3fb950", fontSize:13 }}><div style={{ width:20, height:20, margin:"0 auto 6px" }}><Icon.Check /></div>{imageFile.name}</div>
            : <div style={{ color:C.muted, fontSize:13 }}><div style={{ width:22, height:22, margin:"0 auto 6px" }}><Icon.Upload /></div>คลิกเพื่อเลือกรูปภาพ (max 10MB)</div>}
          {initial?.image_path && !imageFile && <div style={{ marginTop:6, color:C.muted2, fontSize:11 }}>มีรูปเดิมอยู่แล้ว</div>}
        </div>
      </Field>
      <div style={{ display:"flex", gap:10, justifyContent:"flex-end", marginTop:8 }}>
        <button onClick={onClose} style={{ padding:"10px 20px", background:C.card, border:`1px solid ${C.border2}`, color:C.muted, borderRadius:8, cursor:"pointer", fontSize:14, fontFamily:"inherit" }}>ยกเลิก</button>
        <button onClick={handleSave} disabled={saving}
          style={{ padding:"10px 24px", background:saving?"#30363d":`linear-gradient(135deg, ${C.blue}, #2196a8)`, border:"none", color:"#fff", borderRadius:8, cursor:"pointer", fontSize:14, fontWeight:700, fontFamily:"inherit", boxShadow:saving?"none":`0 4px 16px ${C.blue}40` }}>
          {saving?"กำลังบันทึก...":(initial?.id?"บันทึกการแก้ไข":"เพิ่มอุปกรณ์")}
        </button>
      </div>
    </div>
  );
};

// ─── Searchable Dropdown ─────────────────────────────────────
const SearchableSelect = ({ options = [], value, onChange, placeholder = "-- เลือก --" }) => {
  const [open, setOpen]     = useState(false);
  const [search, setSearch] = useState("");
  const wrapRef             = useRef(null);
  const selected = options.find(o => o.value === value);
  const filtered = options.filter(o => o.label.toLowerCase().includes(search.toLowerCase()));

  useEffect(() => {
    const handleClick = (e) => {
      if (wrapRef.current && !wrapRef.current.contains(e.target)) {
        setOpen(false); setSearch("");
      }
    };
    document.addEventListener("mousedown", handleClick);
    return () => document.removeEventListener("mousedown", handleClick);
  }, []);

  return (
    <div ref={wrapRef} style={{ position: "relative", width: "100%" }}>
      <div onClick={() => setOpen(p => !p)}
        style={{ padding: "10px 14px", background: "#0D1117", border: `1px solid ${C.border2}`, borderRadius: 8,
          color: selected ? C.text : C.muted, cursor: "pointer", display: "flex", justifyContent: "space-between",
          alignItems: "center", fontSize: 14, fontFamily: "inherit" }}>
        <span style={{ overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>
          {selected ? selected.label : placeholder}
        </span>
        <span style={{ fontSize: 10, opacity: 0.5, flexShrink: 0, marginLeft: 8 }}>{open ? "▲" : "▼"}</span>
      </div>
      {open && (
        <div style={{ position: "absolute", top: "calc(100% + 4px)", left: 0, right: 0, background: C.card,
          border: `1px solid ${C.border2}`, borderRadius: 8, zIndex: 9999, maxHeight: 280,
          display: "flex", flexDirection: "column", boxShadow: "0 8px 32px rgba(0,0,0,0.6)" }}>
          <div style={{ padding: 8 }}>
            <input autoFocus placeholder="🔍 ค้นหาอุปกรณ์..." value={search}
              onChange={e => setSearch(e.target.value)}
              style={{ width: "100%", padding: "7px 10px", background: "#0D1117", border: `1px solid ${C.border2}`,
                borderRadius: 6, color: C.text, outline: "none", fontSize: 13, fontFamily: "inherit", boxSizing: "border-box" }} />
          </div>
          <div style={{ overflowY: "auto", maxHeight: 210 }}>
            {filtered.length === 0
              ? <div style={{ padding: "12px", color: C.muted, textAlign: "center", fontSize: 13 }}>ไม่พบอุปกรณ์</div>
              : filtered.map(opt => (
                <div key={opt.value} onClick={() => { onChange(opt.value, opt); setOpen(false); setSearch(""); }}
                  style={{ padding: "8px 14px", cursor: "pointer", fontSize: 13,
                    color: opt.value === value ? C.blue : "#ccc",
                    background: opt.value === value ? "#21262d" : "transparent" }}
                  onMouseEnter={e => e.currentTarget.style.background = "#21262d"}
                  onMouseLeave={e => e.currentTarget.style.background = opt.value === value ? "#21262d" : "transparent"}>
                  {opt.label}
                </div>
              ))
            }
          </div>
        </div>
      )}
    </div>
  );
};

// ─── Borrow Form ─────────────────────────────────────────────
const BorrowForm = ({ equipment, history, onSave, onClose }) => {
  const today = new Date().toISOString().split("T")[0];
  const nextNo = String((history||[]).length + 1).padStart(3, "0");
  const [form, setForm] = useState({ doc_no:`BRW-${nextNo}`, equipment_code:"", borrow_qty:1, borrower:"", department:"", borrow_date:today, notes:"" });
  const [saving, setSaving] = useState(false);
  const set = (k,v) => setForm(f=>({...f,[k]:v}));

  // คำนวณคงเหลือ real-time
  const selEq = equipment.find(e=>e.code===form.equipment_code);
  const borrowedQty = (history||[]).filter(h=>h.return_status==="ยังไม่คืน" && h.equipment_code===form.equipment_code)
    .reduce((sum,h)=>sum+(parseInt(h.borrow_qty)||1),0);
  const avail = selEq ? Math.max(0,(selEq.quantity||0)-borrowedQty) : null;
  const isOverQty = avail !== null && form.borrow_qty > avail;

  const handleSave = async () => {
    if (!form.equipment_code) { alert("กรุณาเลือกอุปกรณ์"); return; }
    if (!form.borrower) { alert("กรุณากรอกชื่อผู้เบิก"); return; }
    if (isOverQty) { alert(`ของคงเหลือแค่ ${avail} ชิ้น ไม่สามารถเบิกเกินได้`); return; }
    if (avail === 0) { alert("ของหมดแล้ว ไม่สามารถเบิกได้"); return; }
    setSaving(true);
    try {
      await fetch(`${API}/history`,{method:"POST",headers:{"Content-Type":"application/json"},
        body:JSON.stringify({
          doc_no:           form.doc_no,
          equipment_code:   form.equipment_code,
          equipment_name:   selEq?.name || form.equipment_code,
          type:             "เบิก",
          borrow_qty:       form.borrow_qty,
          borrower:         form.borrower,
          department:       form.department,
          borrow_date:      form.borrow_date,
          notes:            form.notes,
        })});
      onSave();
    } catch(e) { alert("Error: "+e.message); }
    setSaving(false);
  };

  return (
    <div>
      <div style={{ display:"grid", gridTemplateColumns:"1fr 1fr", gap:14 }}>
        <Field label="เลขที่เอกสาร"><Input value={form.doc_no} onChange={e=>set("doc_no",e.target.value)} /></Field>
        <Field label="อุปกรณ์">
          <SearchableSelect
            options={equipment.map(e => ({ value: e.code, label: `${e.code} — ${e.name}`, eq: e }))}
            value={form.equipment_code}
            onChange={(val, opt) => { set("equipment_code", val); set("borrow_qty", 1); if (opt?.eq?.team) set("department", opt.eq.team); }}
            placeholder="-- เลือกอุปกรณ์ --"
          />
          {selEq && (
            <div style={{ marginTop:6, fontSize:12, fontWeight:600, color:avail===0?"#f85149":avail<=2?C.yellow:"#3fb950" }}>
              {avail===0 ? "⛔ ของหมดแล้ว ไม่สามารถเบิกได้" : `✅ คงเหลือ ${avail} / ${selEq.quantity} ชิ้น`}
              {avail>0 && borrowedQty>0 && <span style={{ color:C.muted, fontWeight:400 }}> (ออกไป {borrowedQty} ชิ้น)</span>}
            </div>
          )}
        </Field>
        <Field label="จำนวนที่เบิก">
          <Input type="number" min={1} max={avail||999} value={form.borrow_qty}
            onChange={e=>set("borrow_qty",Math.max(1,+e.target.value))}
            style={{ borderColor:isOverQty?"#da3633":undefined }} />
          {isOverQty && <div style={{ fontSize:11, color:"#f85149", marginTop:4 }}>⚠️ เกินจำนวนคงเหลือ ({avail} ชิ้น)</div>}
        </Field>
        <Field label="ชื่อผู้เบิก *"><Input value={form.borrower} onChange={e=>set("borrower",e.target.value)} placeholder="ชื่อ-นามสกุล" /></Field>
        <Field label="ทีม">
          <Select value={form.department} onChange={e=>set("department",e.target.value)}>
            <option value="">-- เลือกประเภท --</option>
            {["Production","Event","Other"].map(t=><option key={t}>{t}</option>)}
          </Select>
        </Field>
        <Field label="วันที่เบิก"><Input type="date" value={form.borrow_date} onChange={e=>set("borrow_date",e.target.value)} /></Field>
      </div>
      <Field label="รายละเอียดการเบิก / หมายเหตุ">
        <textarea value={form.notes} onChange={e=>set("notes",e.target.value)}
          style={{ width:"100%", background:"#0D1117", border:`1px solid ${C.border2}`, borderRadius:8, padding:"10px 14px", color:C.text, fontSize:13, fontFamily:"inherit", resize:"vertical", minHeight:72, outline:"none", boxSizing:"border-box" }} />
      </Field>
      <div style={{ display:"flex", gap:10, justifyContent:"flex-end" }}>
        <button onClick={onClose} style={{ padding:"10px 20px", background:C.card, border:`1px solid ${C.border2}`, color:C.muted, borderRadius:8, cursor:"pointer", fontSize:14, fontFamily:"inherit" }}>ยกเลิก</button>
        <button onClick={handleSave} disabled={saving||avail===0}
          style={{ padding:"10px 24px", background:saving||avail===0?"#30363d":`linear-gradient(135deg, ${C.yellow}, #c9a010)`, border:"none", color:saving||avail===0?"#666":"#1a1a0a", borderRadius:8, cursor:saving||avail===0?"not-allowed":"pointer", fontSize:14, fontWeight:800, fontFamily:"inherit" }}>
          {saving?"กำลังบันทึก...":"บันทึกการเบิก"}
        </button>
      </div>
    </div>
  );
};

// ─── MAIN APP ────────────────────────────────────────────────
export default function App() {
  const [user, setUser]   = useState(null);
  const [tab,  setTab]    = useState("overview");
  const [equipment, setEquipment] = useState([]);
  const [history,   setHistory]   = useState([]);
  const [stats,     setStats]     = useState({});
  const [q,         setQ]         = useState("");
  const [filterStatus, setFilterStatus] = useState("");
  const [filterTeam,   setFilterTeam]   = useState("");
  const [modal,    setModal]   = useState(null);
  const [selected, setSelected] = useState(null);
  const [loading,  setLoading]  = useState(false);

  const isManager = true;

  const loadAll = useCallback(async () => {
  if (!user) return;
  setLoading(true);
  try {
    const params = new URLSearchParams();
    if (q)            params.set("q", q);
    if (filterStatus) params.set("status", filterStatus);
    if (filterTeam)   params.set("team", filterTeam);

    // ✅ แยกเป็น try-catch ทีละตัว แทน Promise.all
    // เพื่อให้ตัวที่ fail ไม่กระทบตัวอื่น
    const [eqRes, hiRes, stRes] = await Promise.allSettled([
      fetch(`${API}/equipment?${params}`).then(r => r.json()),
      fetch(`${API}/history`).then(r => r.json()),
      fetch(`${API}/equipment/stats`).then(r => r.json()),
    ]);

    if (eqRes.status === "fulfilled") setEquipment(eqRes.value.data || []);
    else console.error("❌ equipment fetch failed:", eqRes.reason);

    if (hiRes.status === "fulfilled") setHistory(hiRes.value.data || []);
    else console.error("❌ history fetch failed:", hiRes.reason);

    if (stRes.status === "fulfilled") setStats(stRes.value.data || {});
    else console.error("❌ stats fetch failed:", stRes.reason);

  } catch(e) {
    console.error("loadAll error:", e);
  }
  setLoading(false);
}, [user, q, filterStatus, filterTeam]);

  useEffect(() => { loadAll(); }, [loadAll]);

  const handleReturn = async (id) => {
    if (!confirm("ยืนยันการคืนอุปกรณ์?")) return;
    await fetch(`${API}/history/${id}/return`,{method:"PATCH",headers:{"Content-Type":"application/json"},body:JSON.stringify({return_date:new Date().toISOString().split("T")[0]})});
    loadAll();
  };
  const handleDeleteEquip = async (id) => {
    if (!confirm("ลบอุปกรณ์นี้?")) return;
    await fetch(`${API}/equipment/${id}`,{method:"DELETE"});
    loadAll();
  };
  const closeModal = () => { setModal(null); setSelected(null); };

  if (!user) return <LoginPage onLogin={setUser} />;

  // ─── Build "who is borrowing" map (รองรับหลายคนยืมพร้อมกัน) ───
  const borrowMap = {}; // { code: [{borrower, qty, notes}] }
  const borrowedQtyMap = {}; // { code: totalQtyOut }
  history.filter(h=>h.return_status==="ยังไม่คืน").forEach(h=>{
    if (h.equipment_code) {
      if (!borrowMap[h.equipment_code]) borrowMap[h.equipment_code] = [];
      const qty = parseInt(h.borrow_qty)||1;
      borrowMap[h.equipment_code].push({ borrower:h.borrower, qty, notes:h.notes });
      borrowedQtyMap[h.equipment_code] = (borrowedQtyMap[h.equipment_code]||0) + qty;
    }
  });
  // คงเหลือจริง = ทั้งหมด - ที่ออกไปยังไม่คืน
  const availableQty = (eq) => Math.max(0, (eq.quantity||0) - (borrowedQtyMap[eq.code]||0));

  const TEAM_COLOR = { Production:{bg:"#0c1e3b",text:"#58a6ff",border:"#1f4e8c"}, Event:{bg:"#1c0c3b",text:"#d2a8ff",border:"#7c3aed"}, Other:{bg:"#1a1a2e",text:"#94a3b8",border:"#334155"} };

  const s = {
    app:    { minHeight:"100vh", background:C.dark, color:C.text, fontFamily:'"IBM Plex Sans Thai","IBM Plex Sans",system-ui,sans-serif', display:"flex", flexDirection:"column" },
    header: { background:"#0D1117", borderBottom:`1px solid ${C.border}`, padding:"0 24px", display:"flex", alignItems:"center", gap:20, height:58, flexShrink:0, boxShadow:"0 1px 0 rgba(255,255,255,0.05)" },
    main:   { flex:1, padding:"24px", maxWidth:1400, margin:"0 auto", width:"100%", boxSizing:"border-box" },
    grid4:  { display:"grid", gridTemplateColumns:"repeat(auto-fit, minmax(180px, 1fr))", gap:14, marginBottom:22 },
    table:  { width:"100%", borderCollapse:"collapse", fontSize:13 },
    th:     { padding:"10px 14px", textAlign:"left", color:C.muted, fontSize:11, fontWeight:700, letterSpacing:"0.07em", textTransform:"uppercase", borderBottom:`1px solid ${C.border}`, background:"#0D1117" },
    td:     { padding:"11px 14px", borderBottom:`1px solid ${C.border}`, color:"#c9d1d9", verticalAlign:"middle" },
    card:   { background:C.card, border:`1px solid ${C.border}`, borderRadius:12, overflow:"hidden" },
    toolbar:{ display:"flex", gap:12, marginBottom:18, alignItems:"center", flexWrap:"wrap" },
    btnBlue: { display:"flex", alignItems:"center", gap:7, padding:"9px 18px", background:`linear-gradient(135deg, ${C.blue}, #2196a8)`, border:"none", color:"#fff", borderRadius:8, cursor:"pointer", fontSize:13, fontWeight:700, fontFamily:"inherit", flexShrink:0, boxShadow:`0 4px 14px ${C.blue}35` },
    btnYellow: { display:"flex", alignItems:"center", gap:7, padding:"9px 18px", background:`linear-gradient(135deg, ${C.yellow}, #c9a010)`, border:"none", color:"#1a1a0a", borderRadius:8, cursor:"pointer", fontSize:13, fontWeight:800, fontFamily:"inherit", flexShrink:0 },
    searchBox: { display:"flex", alignItems:"center", gap:8, background:C.card, border:`1px solid ${C.border2}`, borderRadius:8, padding:"8px 14px", flex:1, minWidth:200, maxWidth:320 },
    navBtn: (active) => ({ padding:"7px 16px", borderRadius:8, border:"none", background:active?"#21262d":"none", color:active?C.text:C.muted, cursor:"pointer", fontSize:13, fontWeight:active?600:400, transition:"all .15s", fontFamily:"inherit", borderBottom:active?`2px solid ${C.blue}`:"2px solid transparent" }),
  };

  const TABS = [
    { id:"overview",  label:"ภาพรวม",         show:true },
    { id:"equipment", label:"รายการอุปกรณ์",    show:true },
    { id:"history",   label:"ประวัติเบิก-คืน", show:true },
  ];

  // ─── Overview ────────────────────────────────────────────────
  const Overview = () => (
    <div>
      <div style={s.grid4}>
        <KPICard label="อุปกรณ์ทั้งหมด" value={stats.total}   accent={C.blue}   icon={Icon.Box}   />
        <KPICard label="สถานะปกติ"      value={stats.normal}  accent="#3fb950"  icon={Icon.Check} sub={`${stats.health??0}% สุขภาพ`} />
        <KPICard label="ชำรุด/ส่งซ่อม"  value={(stats.damaged||0)+(stats.repair||0)} accent="#f85149" icon={Icon.Alert} />
        <KPICard label="กำลังถูกยืม"     value={stats.borrowed} accent={C.yellow} icon={Icon.Clock} />
      </div>

      <div style={{ ...s.card, padding:"18px 22px", marginBottom:20 }}>
        <div style={{ display:"flex", justifyContent:"space-between", alignItems:"center", marginBottom:10 }}>
          <span style={{ fontSize:13, color:C.muted, fontWeight:600 }}>สุขภาพอุปกรณ์โดยรวม</span>
          <span style={{ fontSize:24, fontWeight:900, color:stats.health>=95?"#3fb950":stats.health>=80?C.yellow:"#f85149" }}>{stats.health??0}%</span>
        </div>
        <div style={{ height:8, background:"#21262d", borderRadius:99, overflow:"hidden" }}>
          <div style={{ height:"100%", width:`${stats.health||0}%`, background:stats.health>=95?"#3fb950":stats.health>=80?C.yellow:"#f85149", borderRadius:99, transition:"width 0.8s ease" }} />
        </div>
      </div>

      {/* Who is borrowing */}
      <div style={{ ...s.card, marginBottom:20 }}>
        <div style={{ padding:"14px 18px", borderBottom:`1px solid ${C.border}`, display:"flex", alignItems:"center", gap:8 }}>
          <div style={{ width:16, height:16, color:C.yellow }}><Icon.Clock /></div>
          <span style={{ fontSize:14, fontWeight:700 }}>กำลังถูกยืมอยู่</span>
        </div>
        <table style={s.table}>
          <thead><tr>{["รหัส","ชื่ออุปกรณ์","ผู้ยืม","วันที่เบิก"].map(h=><th key={h} style={s.th}>{h}</th>)}</tr></thead>
          <tbody>
            {history.filter(h=>h.return_status==="ยังไม่คืน").slice(0,8).map(h=>(
              <tr key={h.id}>
                <td style={s.td}><code style={{ color:C.yellow, fontSize:12 }}>{h.equipment_code||"—"}</code></td>
                <td style={s.td} style={{ color:C.text, fontWeight:500 }}>{h.equipment_name||"—"}</td>
                <td style={s.td}>
                  <div style={{ display:"flex", alignItems:"center", gap:6 }}>
                    <div style={{ width:24, height:24, borderRadius:"50%", background:`${C.blue}20`, display:"flex", alignItems:"center", justifyContent:"center", color:C.blue, fontSize:10, fontWeight:700, flexShrink:0 }}>
                      {h.borrower?.[0]?.toUpperCase()||"?"}
                    </div>
                    <span>{h.borrower}</span>
                    {h.department && <span style={{ fontSize:11, color:C.muted }}>({h.department})</span>}
                  </div>
                </td>
                <td style={s.td} style={{ color:C.muted, fontSize:12 }}>{h.borrow_date||"—"}</td>
              </tr>
            ))}
            {history.filter(h=>h.return_status==="ยังไม่คืน").length===0 && (
              <tr><td colSpan={4} style={{ ...s.td, textAlign:"center", padding:32, color:C.muted2 }}>✅ ไม่มีอุปกรณ์ที่ถูกยืม</td></tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Damaged */}
      {isManager && (
        <div style={s.card}>
          <div style={{ padding:"14px 18px", borderBottom:`1px solid ${C.border}`, display:"flex", alignItems:"center", gap:8 }}>
            <div style={{ width:16, height:16, color:"#f85149" }}><Icon.Alert /></div>
            <span style={{ fontSize:14, fontWeight:700 }}>อุปกรณ์ที่ต้องดูแล</span>
          </div>
          <table style={s.table}>
            <thead><tr>{["รหัส","ชื่อ","ทีม","สถานะ"].map(h=><th key={h} style={s.th}>{h}</th>)}</tr></thead>
            <tbody>
              {equipment.filter(e=>e.status!=="ปกติ").slice(0,8).map(e=>(
                <tr key={e.id}>
                  <td style={s.td}><code style={{ color:C.blue, fontSize:12 }}>{e.code}</code></td>
                  <td style={s.td} style={{ color:C.text }}>{e.name}</td>
                  <td style={s.td}><Badge label={e.team} colorMap={TEAM_COLOR} /></td>
                  <td style={s.td}><Badge label={e.status} colorMap={STATUS_COLOR} /></td>
                </tr>
              ))}
              {equipment.filter(e=>e.status!=="ปกติ").length===0 && (
                <tr><td colSpan={4} style={{ ...s.td, textAlign:"center", padding:32, color:C.muted2 }}>✅ ทุกอุปกรณ์อยู่ในสภาพดี</td></tr>
              )}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );

  // ─── Equipment Tab ───────────────────────────────────────────
  const EquipmentTab = () => (
    <div>
      <div style={s.toolbar}>
        <div style={s.searchBox}>
          <div style={{ width:16, height:16, color:C.muted, flexShrink:0 }}><Icon.Search /></div>
          <input value={q} onChange={e=>setQ(e.target.value)} placeholder="ค้นหารหัส, ชื่ออุปกรณ์..."
            style={{ background:"none", border:"none", outline:"none", color:C.text, fontSize:13, width:"100%", fontFamily:"inherit" }} />
        </div>
        <Select value={filterStatus} onChange={e=>setFilterStatus(e.target.value)} style={{ width:"auto", minWidth:130 }}>
          <option value="">ทุกสถานะ</option>
          {["ปกติ","ชำรุด","ส่งซ่อม"].map(s=><option key={s}>{s}</option>)}
        </Select>
        <Select value={filterTeam} onChange={e=>setFilterTeam(e.target.value)} style={{ width:"auto", minWidth:120 }}>
          <option value="">ทุกทีม</option>
          {["Production","Event","Other"].map(t=><option key={t}>{t}</option>)}
        </Select>
        {isManager && (
          <button style={s.btnBlue} onClick={()=>setModal("addEquip")}>
            <div style={{ width:16, height:16 }}><Icon.Plus /></div> เพิ่มอุปกรณ์
          </button>
        )}
      </div>
      <div style={s.card}>
        <table style={s.table}>
          <thead><tr>
            {["รูป","รหัส","ชื่ออุปกรณ์","หมวด","ทีม","สถานะ","จำนวน","ผู้ยืม",isManager?"":""].map((h,i)=><th key={i} style={s.th}>{h}</th>)}
          </tr></thead>
          <tbody>
            {loading ? <tr><td colSpan={9} style={{ ...s.td, textAlign:"center", padding:48, color:C.muted }}>กำลังโหลด...</td></tr>
            : equipment.length===0 ? <tr><td colSpan={9} style={{ ...s.td, textAlign:"center", padding:48, color:C.muted2 }}>ไม่พบข้อมูล</td></tr>
            : equipment.map(eq=>(
              <tr key={eq.id} style={{ cursor:"pointer", transition:"background .1s" }}
                onMouseEnter={e=>e.currentTarget.style.background="#161b22"}
                onMouseLeave={e=>e.currentTarget.style.background=""}
                onClick={()=>{ setSelected(eq); setModal("detail"); }}>
                <td style={s.td} onClick={e=>e.stopPropagation()}>
                  {eq.image_path
                    ? <img src={`${API}${eq.image_path}`} alt="" style={{ width:42, height:42, objectFit:"cover", borderRadius:8, border:`1px solid ${C.border2}` }} />
                    : <div style={{ width:42, height:42, background:"#21262d", borderRadius:8, display:"flex", alignItems:"center", justifyContent:"center", color:C.muted2 }}><div style={{ width:18, height:18 }}><Icon.Image /></div></div>
                  }
                </td>
                <td style={s.td}><code style={{ color:C.blue, fontSize:12, fontWeight:700 }}>{eq.code}</code></td>
                <td style={s.td}><span style={{ color:C.text, fontWeight:500 }}>{eq.name}</span>
                  {eq.description && <div style={{ fontSize:11, color:C.muted, marginTop:2, maxWidth:240, overflow:"hidden", textOverflow:"ellipsis", whiteSpace:"nowrap" }}>{eq.description}</div>}
                </td>
                <td style={s.td} style={{ color:C.muted, fontSize:12 }}>{eq.category||"—"}</td>
                <td style={s.td}><Badge label={eq.team} colorMap={TEAM_COLOR} /></td>
                <td style={s.td}><Badge label={eq.status} colorMap={STATUS_COLOR} /></td>
                <td style={s.td} style={{ textAlign:"center" }}>
                  <div style={{ fontSize:13, fontWeight:700, color:availableQty(eq)===0?"#f85149":availableQty(eq)<=2?C.yellow:"#3fb950" }}>
                    {availableQty(eq)}/{eq.quantity}
                  </div>
                  <div style={{ fontSize:10, color:C.muted2 }}>คงเหลือ</div>
                </td>
                <td style={s.td}>
                  {borrowMap[eq.code]?.length > 0
                    ? <div style={{ display:"flex", flexDirection:"column", gap:3 }}>
                        {borrowMap[eq.code].map((b,i)=>(
                          <div key={i} style={{ display:"flex", alignItems:"center", gap:5 }}>
                            <div style={{ width:20, height:20, borderRadius:"50%", background:`${C.yellow}20`, display:"flex", alignItems:"center", justifyContent:"center", color:C.yellow, fontSize:9, fontWeight:700, flexShrink:0 }}>
                              {b.borrower?.[0]?.toUpperCase()||"?"}
                            </div>
                            <span style={{ fontSize:12, color:C.yellow, fontWeight:600 }}>{b.borrower}</span>
                            <span style={{ fontSize:11, color:C.muted, background:"#21262d", borderRadius:4, padding:"1px 5px" }}>{b.qty} ชิ้น</span>
                          </div>
                        ))}
                      </div>
                    : <span style={{ color:C.muted2, fontSize:12 }}>—</span>
                  }
                </td>
                {isManager && (
                  <td style={s.td} onClick={e=>e.stopPropagation()}>
                    <div style={{ display:"flex", gap:6 }}>
                      <button onClick={()=>{ setSelected(eq); setModal("editEquip"); }}
                        style={{ background:"none", border:`1px solid ${C.border2}`, color:C.muted, cursor:"pointer", borderRadius:6, padding:6, display:"flex" }}>
                        <div style={{ width:14, height:14 }}><Icon.Edit /></div>
                      </button>
                      <button onClick={()=>handleDeleteEquip(eq.id)}
                        style={{ background:"none", border:`1px solid #da363330`, color:"#f85149", cursor:"pointer", borderRadius:6, padding:6, display:"flex" }}>
                        <div style={{ width:14, height:14 }}><Icon.Trash /></div>
                      </button>
                    </div>
                  </td>
                )}
              </tr>
            ))}
          </tbody>
        </table>
        <div style={{ padding:"10px 18px", borderTop:`1px solid ${C.border}`, color:C.muted2, fontSize:12 }}>{equipment.length} รายการ</div>
      </div>
    </div>
  );

  // ─── History Tab ─────────────────────────────────────────────
  const HistoryTab = () => (
    <div>
      <div style={s.toolbar}>
        <div style={s.searchBox}>
          <div style={{ width:16, height:16, color:C.muted, flexShrink:0 }}><Icon.Search /></div>
          <input placeholder="ค้นหาผู้เบิก, อุปกรณ์..." style={{ background:"none", border:"none", outline:"none", color:C.text, fontSize:13, width:"100%", fontFamily:"inherit" }} />
        </div>
        <button style={s.btnYellow} onClick={()=>setModal("borrow")}>
          <div style={{ width:16, height:16 }}><Icon.Plus /></div> บันทึกการเบิก
        </button>
      </div>
      <div style={s.card}>
        <table style={s.table}>
          <thead><tr>{["เลขที่","รหัส","ชื่ออุปกรณ์","ผู้เบิก","ทีม","วันที่เบิก","สถานะ","รายละเอียดการเบิก",""].map(h=><th key={h} style={s.th}>{h}</th>)}</tr></thead>
          <tbody>
            {history.map(h=>(
              <tr key={h.id} style={{ transition:"background .1s" }}
                onMouseEnter={e=>e.currentTarget.style.background="#161b22"}
                onMouseLeave={e=>e.currentTarget.style.background=""}>
                <td style={s.td}><code style={{ color:C.muted, fontSize:11 }}>{h.doc_no}</code></td>
                <td style={s.td}><code style={{ color:C.blue, fontSize:12 }}>{h.equipment_code||"—"}</code></td>
                <td style={s.td} style={{ color:C.text, fontWeight:500 }}>{h.equipment_name||"—"}</td>
                <td style={s.td}>
                  <div style={{ display:"flex", alignItems:"center", gap:6 }}>
                    <div style={{ width:26, height:26, borderRadius:"50%", background:`${C.blue}20`, display:"flex", alignItems:"center", justifyContent:"center", color:C.blue, fontSize:11, fontWeight:700, flexShrink:0 }}>
                      {h.borrower?.[0]?.toUpperCase()||"?"}
                    </div>
                    <span style={{ fontWeight:600 }}>{h.borrower}</span>
                  </div>
                </td>
                <td style={s.td} style={{ color:C.muted, fontSize:12 }}>{h.department||"—"}</td>
                <td style={s.td} style={{ color:C.muted, fontSize:12 }}>{h.borrow_date||"—"}</td>
                <td style={s.td}><Badge label={h.return_status} colorMap={RETURN_COLOR} /></td>
                <td style={s.td} style={{ color:C.muted, fontSize:11, maxWidth:160, overflow:"hidden", textOverflow:"ellipsis", whiteSpace:"nowrap" }}>{h.notes||"—"}</td>
                <td style={s.td}>
                  {h.return_status==="ยังไม่คืน" && (
                    <button onClick={()=>handleReturn(h.id)}
                      style={{ display:"flex", alignItems:"center", gap:4, padding:"5px 10px", background:"#0d2818", border:"1px solid #238636", color:"#3fb950", borderRadius:6, cursor:"pointer", fontSize:11, fontFamily:"inherit" }}>
                      <div style={{ width:12, height:12 }}><Icon.Return /></div> คืน
                    </button>
                  )}
                </td>
              </tr>
            ))}
            {history.length===0 && <tr><td colSpan={9} style={{ ...s.td, textAlign:"center", padding:48, color:C.muted2 }}>ยังไม่มีประวัติการเบิก</td></tr>}
          </tbody>
        </table>
        <div style={{ padding:"10px 18px", borderTop:`1px solid ${C.border}`, color:C.muted2, fontSize:12 }}>{history.length} รายการ</div>
      </div>
    </div>
  );

  return (
    <div style={s.app}>
      <header style={s.header}>
        <img src={LOGO_B64} alt="DNAT" style={{ height:34, width:"auto", objectFit:"contain" }} />
        <div style={{ width:1, height:28, background:C.border, flexShrink:0 }} />
        <nav style={{ display:"flex", gap:2, flex:1 }}>
          {TABS.filter(t=>t.show).map(t=>(
            <button key={t.id} style={s.navBtn(tab===t.id)} onClick={()=>setTab(t.id)}>{t.label}</button>
          ))}
        </nav>
        <div style={{ display:"flex", alignItems:"center", gap:12 }}>
          <div style={{ textAlign:"right" }}>
            <div style={{ fontSize:13, fontWeight:700, color:C.text }}>{user.icon} {user.name}</div>
            <div style={{ fontSize:11, color:C.muted }}>{user.username}</div>
          </div>
          <button onClick={()=>setUser(null)}
            style={{ background:"none", border:`1px solid ${C.border2}`, color:C.muted, cursor:"pointer", borderRadius:8, padding:"6px 10px", display:"flex", alignItems:"center", gap:6, fontSize:12, fontFamily:"inherit" }}>
            <div style={{ width:14, height:14 }}><Icon.Logout /></div> ออก
          </button>
        </div>
      </header>

      <main style={s.main}>
        {tab==="overview"  && <Overview />}
        {tab==="equipment" && <EquipmentTab />}
        {tab==="history"   && <HistoryTab />}
      </main>

      <Modal open={modal==="addEquip"} onClose={closeModal} title="เพิ่มอุปกรณ์ใหม่">
        <EquipmentForm onSave={()=>{ loadAll(); closeModal(); }} onClose={closeModal} />
      </Modal>
      <Modal open={modal==="editEquip"} onClose={closeModal} title={`แก้ไขอุปกรณ์: ${selected?.code}`}>
        <EquipmentForm initial={selected} onSave={()=>{ loadAll(); closeModal(); }} onClose={closeModal} />
      </Modal>
      <Modal open={modal==="borrow"} onClose={closeModal} title="บันทึกการเบิกอุปกรณ์" width={540}>
        <BorrowForm equipment={equipment} history={history} onSave={()=>{ loadAll(); closeModal(); }} onClose={closeModal} />
      </Modal>
      <Modal open={modal==="detail" && !!selected} onClose={closeModal} title={`รายละเอียด: ${selected?.code}`} width={480}>
        {selected && (
          <div>
            {selected.image_path && <img src={`${API}${selected.image_path}`} alt="" style={{ width:"100%", height:200, objectFit:"cover", borderRadius:10, marginBottom:16, border:`1px solid ${C.border2}` }} />}
            <div style={{ display:"grid", gridTemplateColumns:"1fr 1fr", gap:10 }}>
              {[["รหัส",selected.code],["ชื่อ",selected.name],["หมวดหมู่",selected.category||"—"],["ทีม",selected.team],["สถานะ",selected.status],["ที่เก็บ",selected.location||"—"],["จำนวน",selected.quantity]].map(([k,v])=>(
                <div key={k} style={{ background:"#0D1117", borderRadius:8, padding:"11px 14px" }}>
                  <div style={{ fontSize:10, color:C.muted, fontWeight:700, marginBottom:3, textTransform:"uppercase", letterSpacing:"0.06em" }}>{k}</div>
                  <div style={{ color:C.text, fontSize:14, fontWeight:500 }}>{v}</div>
                </div>
              ))}
            </div>
            {selected.description && (
              <div style={{ marginTop:10, background:"#0D1117", borderRadius:8, padding:"11px 14px" }}>
                <div style={{ fontSize:10, color:C.muted, fontWeight:700, marginBottom:4, textTransform:"uppercase", letterSpacing:"0.06em" }}>รายละเอียด</div>
                <div style={{ color:"#c9d1d9", fontSize:13, lineHeight:1.6 }}>{selected.description}</div>
              </div>
            )}
            {borrowMap[selected.code]?.length > 0 && (
              <div style={{ marginTop:10, background:"#2d1d0e", border:"1px solid #9e6a03", borderRadius:8, padding:"11px 14px" }}>
                <div style={{ fontSize:11, color:C.yellow, fontWeight:700, marginBottom:8 }}>
                  ⚠️ กำลังถูกยืม — คงเหลือ {availableQty(selected)}/{selected.quantity} ชิ้น
                </div>
                {borrowMap[selected.code].map((b,i)=>(
                  <div key={i} style={{ display:"flex", justifyContent:"space-between", alignItems:"center", padding:"5px 0", borderBottom:i<borrowMap[selected.code].length-1?`1px solid #9e6a0330`:undefined }}>
                    <div style={{ display:"flex", alignItems:"center", gap:6 }}>
                      <div style={{ width:22, height:22, borderRadius:"50%", background:`${C.yellow}20`, display:"flex", alignItems:"center", justifyContent:"center", color:C.yellow, fontSize:10, fontWeight:700 }}>
                        {b.borrower?.[0]?.toUpperCase()||"?"}
                      </div>
                      <span style={{ color:C.yellow, fontSize:13, fontWeight:600 }}>{b.borrower}</span>
                    </div>
                    <span style={{ background:"#3d2a00", border:"1px solid #9e6a03", borderRadius:6, padding:"2px 10px", color:C.yellow, fontSize:12, fontWeight:700 }}>{b.qty} ชิ้น</span>
                  </div>
                ))}
              </div>
            )}
            {isManager && (
              <div style={{ display:"flex", gap:10, justifyContent:"flex-end", marginTop:16 }}>
                <button onClick={()=>setModal("editEquip")} style={{ display:"flex", alignItems:"center", gap:6, padding:"9px 18px", background:C.card, border:`1px solid ${C.border2}`, color:C.muted, borderRadius:8, cursor:"pointer", fontSize:13, fontFamily:"inherit" }}>
                  <div style={{ width:14, height:14 }}><Icon.Edit /></div> แก้ไข
                </button>
              </div>
            )}
          </div>
        )}
      </Modal>
    </div>
  );
}