abstract class MainStates{}

class MainInitState extends MainStates{}
class MainLoadingState extends MainStates{}
class MainChangeIndexState extends MainStates{}
class MainChangeThemeState extends MainStates{}
class MainFavProductState extends MainStates{}
class MainIncreaseQuantityState extends MainStates{}
class MainDecreaseQuantityState extends MainStates{}

//get products states
class MainGetProductsSuccessState extends MainStates{}
class MainGetProductsErrorState extends MainStates{}

//get user data states
class MainGetUserDataSuccessState extends MainStates{}
class MainGetUserDataErrorState extends MainStates{}

//add to cart
class MainAddToCartSuccessState extends MainStates{}
class MainAddToCartErrorState extends MainStates{}

//remove from cart
class MainRemoveFromCartSuccessState extends MainStates{}
class MainRemoveFromCartErrorState extends MainStates{}

//make order states
class MainMakeOrderSuccessState extends MainStates{}
class MainMakeOrderErrorState extends MainStates{}




