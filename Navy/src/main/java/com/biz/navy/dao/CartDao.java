package com.biz.navy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.biz.navy.domain.CartVO;
import com.biz.navy.domain.ColorVO;
import com.biz.navy.domain.PageVO;
import com.biz.navy.domain.SizeVO;

public interface CartDao {
 

	// 장바구니 보기용 SELECT
	@Select("select C.bk_id, C.bk_p_name, P.p_code, C.bk_p_color, C.bk_p_size, P.p_name, C.username, C.bk_p_oprice, "
			+ " C.bk_p_qty from tbl_cart C"
			+ " LEFT JOIN tbl_product P ON C.bk_p_code = P.p_code "
			+ " where username = #{username} AND bk_p_status = 'CART' ")
	public List<CartVO> selectCart(@Param("username")String username);
	
	@Select("SELECT * FROM tbl_cart")
	public List<CartVO> selectAll();
	
	@Select("SELECT * FROM tbl_cart WHERE bk_p_status = #{status}")
	public List<CartVO> selectByStatus(String status);
	
	
	
	// 배송 중인 상품 SELECT
//	@Select("select C.bk_id, C.bk_p_name, P.p_code, C.bk_p_color, "
//			+ " C.bk_p_size, C.username, C.bk_p_oprice, C.bk_p_qty "
//			+ " from tbl_cart C "
//			+ "LEFT JOIN tbl_product P ON C.bk_p_code = P.p_code "
//			+ " where usernmae = #{username} AND bk_p_status = 'DELIV' ")
//	public List<CartVO> selectDelivery(@Param("username")String username);

	// 관리자가 현재 카트에 몇건이나 담겨있는지 조회할 때
	@Select("select count(*) from tbl_cart where bk_p_status = 'CART' ")
	public int countCart();
	
	public int insert(CartVO cartVO);
	
	@Delete("delete from tbl_cart where bk_id = #{bk_id}")
	public int delete(long bk_id);

	// 주문완료 후 배송중 SELECT
	@Select("select * from tbl_cart where username = #{username} AND bk_p_status = 'DELIV' ")
	public List<CartVO> selectDelivery(@Param("username")String username);
	
	public List<CartVO> paymentList(@Param("username")String username, @Param("pageVO")PageVO pageVO);
	
	// 관리자가 현재 배송중인 상품이 몇건이나 되는지 조회할 때 
	@Select("select count(*) from tbl_cart where bk_p_status = 'DELIV' ")
	public int countDelivery();
	
	@Update("UPDATE tbl_cart set bk_p_qty = #{bk_p_qty} where bk_id = #{bk_id} ")
	public int qty_update(@Param("bk_id")long bk_id, @Param("bk_p_qty")int bk_p_qty) ;

	public int cart_list_delete(List<String> strSeqList);

	public int cart_to_delivery(List<CartVO> cartList);

	@Select("select count(*) from tbl_cart where bk_p_status = 'CART' ")
	public int cartCount();


	@Select("SELECT * FROM tbl_size where s_p_code = #{p_code}")
	public List<SizeVO> findBySpCode(long p_code);
	
	@Select("SELECT * FROM tbl_color where c_s_code = #{c_s_code}")
	public List<ColorVO> findByCsCode(long c_s_code);

	@Select("SELECT * FROM tbl_cart WHERE bk_id = #{bk_id}")
	public CartVO findbyBkId(String bk_id);

	/*
	 * dao에서 list형 변수 1개만을 매개변수로 전달할 경우
	 * collection에 단순히 list라고만 명시하면 되지만
	 * 
	 * dao에서 2개이상의 변수 지정시 param을 꼭 설정해 주어야한다.
	 * 
	 * mapper에서 collection에는 변수이름을 넣어줘야한다.
	 */
	public int recipient_update(@Param("bkSeqList") List<String> bkSeqList, @Param("cartVO") CartVO cartVO);

	@Select("SELECT COUNT(*) FROM tbl_cart")
	public long totalCount();

	// 사용자별로 주문내역 조회
	@Select("SELECT * FROM tbl_cart WHERE username = #{username}")
	public List<CartVO> findByUserId(String username);

	


}
