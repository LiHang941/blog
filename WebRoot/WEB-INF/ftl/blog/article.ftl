<#--
文章显示页面
-->
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${article.index.articletitle!""}</title>
</head>
<#include "common/basejs.ftl">
<body>
<#include "common/banner.ftl"/>
<div class="container blog-content">
<#include "common/head.ftl"/>
    <ol class="breadcrumb blog-breadcrumb">
        <li><a href="/">主页</a></li>
        <li><a href="/c/cid/${article.index.category.id!""}.html">${article.index.category.name !}</a></li>
        <li>${article.index.articletitle!""}</li>
    </ol>

    <div class="row">
        <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8 ">
            <div class="blog-article-article">
                <div class="blog-article-article-head">
                    <h1>${article.index.articletitle!""}</h1>
                    <div class="blog-article-article-head-meta">
                        <table>
                            <tr>
                                <td>作者:${article.index.articleusername !"未知"}</td>
                                <td>时间:${article.index.createtime ?string("yyyy年MM月dd")}</td>
                                <td>浏览次数:${article.index.count!"0"}</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="row">
                    <div class="blog-article-article-content">
                    ${article.index.articlecontent !""}
                    </div>
                    <div class="blog-article-article-head-meta">
                        <table>
                            <tr>
                                <td>标签:<a
                                        href="/c/lid/${article.index.lable.id!""}.html">${article.index.lable.name!"未知"}</a>
                                </td>
                                <td>分类:<a
                                        href="/c/cid/${article.index.category.id!""}.html">${article.index.category.name!"未知"}</a>
                                </td>
                                <td>文章来源:<a
                                        href="${article.index.articlehref!"javascript:;"}">${article.index.articlehreftitle!""}</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!--评论-->
                    <div class="blog-article-comment">
                        <div id="SOHUCS" sid="${article.index.id!}"></div>
                    </div>
                </div>



            </div>

            <div class="blog-article-page">
                <p>
                    上一篇:<#if article.pre?? ><a href="/${article.pre.id!}.html">${article.pre.articletitle!}</a><#else>
                    <span>无</span>  </#if>
                </p>
                <p>
                    下一篇:<#if article.next?? > <a
                        href="/${article.next.id!}.html">${article.next.articletitle!}</a> <#else>
                    <span>没有更多了</span> </#if>
                </p>
            </div>

        </div>
        <div class="hidden-xs col-sm-4 col-md-4 col-lg-4">
        <#include "common/right.ftl">
        </div>
    </div>
</div>
<#include "common/footer.ftl"/>
</body>

<script type="text/javascript">
    (function () {
        var appid = 'cytetzRgz';
        var conf = 'prod_3857fb1d29021998e9718f3346a379b3';
        var width = window.innerWidth || document.documentElement.clientWidth;
        if (width < 960) {
            window.document.write('<script id="changyan_mobile_js" charset="utf-8" type="text/javascript" src="http://changyan.sohu.com/upload/mobile/wap-js/changyan_mobile.js?client_id=' + appid + '&conf=' + conf + '"><\/script>');
        } else {
            var loadJs = function (d, a) {
                var c = document.getElementsByTagName("head")[0] || document.head || document.documentElement;
                var b = document.createElement("script");
                b.setAttribute("type", "text/javascript");
                b.setAttribute("charset", "UTF-8");
                b.setAttribute("src", d);
                if (typeof a === "function") {
                    if (window.attachEvent) {
                        b.onreadystatechange = function () {
                            var e = b.readyState;
                            if (e === "loaded" || e === "complete") {
                                b.onreadystatechange = null;
                                a()
                            }
                        }
                    } else {
                        b.onload = a
                    }
                }
                c.appendChild(b)
            };
            loadJs("http://changyan.sohu.com/upload/changyan.js", function () {
                window.changyan.api.config({appid: appid, conf: conf})
            });
        }
    })();
</script>

</html>