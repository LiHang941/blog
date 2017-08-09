package com.blog.mvc.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.blog.model.Condition;
import com.blog.model.LoginUser;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.blog.mvc.Constant;
import com.blog.mvc.cache.FreemakerCache;
import com.blog.mvc.entity.Article;
import com.blog.mvc.entity.Comment;
import com.blog.mvc.entity.User;
import com.blog.mvc.service.IArticleService;
import com.blog.mvc.service.ICommentService;
import com.blog.mvc.service.ISystemManagerService;
import com.blog.mvc.utils.Page;
import com.blog.mvc.utils.RenderJson;
import com.github.pagehelper.PageHelper;


@Controller
public class MainController extends BaseController{
	
	
	
	private final Log log = LogFactory.getLog(getClass());
	

	@Resource
	private IArticleService articleService;

	
	@Resource
	private ICommentService commentService;
	
	
	/**
	 * 主页
	 * @param model
	 * @param p
	 * @return
	 */
	@RequestMapping(value="/index.action" ,method={RequestMethod.GET})
	public String index(Model model,Integer p) {
		PageHelper.startPage(p == null? 1 : p, Constant.ARTICLE_ITEM_LENGTH);
		List<Article> indexItem = articleService.getIndexItem();
		model.addAttribute("articleList", indexItem);
		model.addAttribute("pageInfo", new Page<>(indexItem));
		return "blog/articleList.ftl";
	}

	/**
	 * 按条件显示
	 * @param model
	 * @param condition
	 * @return
	 */
	@RequestMapping(value="/item.action")
	public String item(Model model,Condition condition) {
		List<Article> indexItem = articleService.getItem(condition);
		model.addAttribute("articleList", indexItem);
		return "blog/articleList.ftl";
	}


	
	/**
	 * 留言板
	 * @return
	 */
	@RequestMapping(value="/message.action" ,method={RequestMethod.GET})
	public String message(){
		return "blog/message.ftl";
	}
	
	/**
	 * 文章
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/article.action" ,method={RequestMethod.GET})
	public String article(Model model,Integer id) {
		model.addAttribute("article", articleService.show(id));
		return "blog/article.ftl";
	}
	
	
	
	
	/**
	 * 评论
	 * @param model
	 * @param comment
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/comment.action" ,method={RequestMethod.GET})
	@ResponseBody
	public RenderJson comment(Model model,Comment comment,User user) {
		try{
			return commentService.comment(comment,user);
		}catch(Exception e){
			return RenderJson.Instance().ERROR().setMessage("请输入邮箱和用户名,方可评论");
		}
	}
	
	
	/**
	 * 获取评论
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/getComment.action" ,method={RequestMethod.GET})
	@ResponseBody
	public RenderJson getComment(Model model,Integer id) {
		model.addAttribute("article", articleService.show(id));
		return RenderJson.Instance();
	}


	/**
	 * 登陆
	 */
	@RequestMapping(value="/loginAdmin.action" )
	public void login(HttpServletRequest request, HttpServletResponse response, String name, String password) throws IOException{


		if(!(StringUtils.isBlank(name) || StringUtils.isBlank(password))){

			LoginUser loginUser = new LoginUser(name,password);

			log.info("登陆User:" + loginUser);
			if(Constant.users.contains(loginUser)){
				request.getSession().setAttribute("userLogin",loginUser);
			}
		}
		response.sendRedirect("/admin/index.action");
	}

	
}
