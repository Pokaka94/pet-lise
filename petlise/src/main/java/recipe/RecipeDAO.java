package recipe;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

@Mapper
public interface RecipeDAO {
    public void insertRecipe(RecipeDTO recipe);      
    
    int likeUp(String recipe_id);
   	int likeDown(String recipe_id);
   	int insertLike(HashMap<String, String> map);
    int deleteLike(HashMap<String, String> map);  	
   	int likeCntRecipe(String recipe_id);
   	boolean isRecipeLiked(@Param("user_id") String user_id, @Param("recipe_id") String recipe_id);
   	// 레시피 등록시 포인트를 업데이트하는 메서드
    public void updateUserPoint(@Param("user_id") String user_id, @Param("amount") int amount);
    int updateRecipeOfMonth(@Param("recipe_id") String recipe_id, @Param("value") int value);
    void recipeViewCount(@Param("recipe_id") String recipe_id);
    RecipeDTO getRecipeDetailById(String recipe_id);

     
   
}
