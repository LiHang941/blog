package com.blog.quartz;

import com.blog.mvc.dao.ArticleMapper;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedDeque;

/**
 * Created by LiHang on 2017/8/7.
 *
 * 文章浏览次数自增任务类
 */
@Component
@Lazy(false)
public class ArticleCountQuartz {

    @Resource
    private ArticleMapper articleMapper;

    Log log = LogFactory.getLog(getClass());

    public ArticleCountQuartz(){
        log.info("创建文章浏览次数自增定时任务");
    }


    private static  Queue<Integer> articleIds = new ConcurrentLinkedDeque<Integer>();

    public static void addArticleId (Integer id){
        articleIds.add(id);
    }


    // 获取并移除此队列的头，如果此队列为空，则返回 null
    public static Integer getAarticleId(){
        return articleIds.poll();
    }

    @Scheduled(cron = "0/1 * * * * ? ")//每隔1s执行一次
    //每次处理五个任务
    public void addCount (){
        try{
            if( articleIds.size() > 0){
                for(int i=0;i<5;i++){
                    Integer aarticleId = getAarticleId();
                    if( null != aarticleId ){
                        log.info("文章浏览次数+1 ----- ID:" + aarticleId );
                        articleMapper.addArticleCount(aarticleId);
                    }else {
                        break;
                    }
                }
            }
        }catch (Exception e){
            log.error(e.getMessage());
        }

    }

}