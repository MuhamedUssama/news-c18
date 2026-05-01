import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_c18/core/remote/network/api_manager.dart';
import 'package:news_c18/model/sources_response/Source.dart';

class SourcesViewModel extends Cubit<SourcesState>{
  SourcesViewModel():super(SourcesLoadingState());

  getSources(String selectedCategory)async{
    try{
      // loading
      emit(SourcesLoadingState());
      var result = await ApiManager.getSources(selectedCategory);
      if(result.status!="error"){
        // success
        emit(SourcesSuccessState(result.sources??[]));
      }else{
        // error
        emit((SourcesErrorState(result.message!)));
      }
    }catch(e){
      // exception error
      emit(SourcesErrorState(e.toString()));
    }
  }
}

sealed class SourcesState{}

class SourcesLoadingState extends SourcesState{}
class SourcesErrorState extends SourcesState{
  String errorMessage;
  SourcesErrorState(this.errorMessage);
}
class SourcesSuccessState extends SourcesState{
  List<Source> sources;
  SourcesSuccessState(this.sources);
}