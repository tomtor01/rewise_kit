// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flashcard_study_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FlashcardStudyState {

 List<Flashcard> get flashcards; int get currentIndex; bool get isRevealed; bool get isLoading; bool get isSessionComplete; List<bool> get answeredCorrectly;// Nowe pole
 String? get error;
/// Create a copy of FlashcardStudyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlashcardStudyStateCopyWith<FlashcardStudyState> get copyWith => _$FlashcardStudyStateCopyWithImpl<FlashcardStudyState>(this as FlashcardStudyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlashcardStudyState&&const DeepCollectionEquality().equals(other.flashcards, flashcards)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.isRevealed, isRevealed) || other.isRevealed == isRevealed)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSessionComplete, isSessionComplete) || other.isSessionComplete == isSessionComplete)&&const DeepCollectionEquality().equals(other.answeredCorrectly, answeredCorrectly)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(flashcards),currentIndex,isRevealed,isLoading,isSessionComplete,const DeepCollectionEquality().hash(answeredCorrectly),error);

@override
String toString() {
  return 'FlashcardStudyState(flashcards: $flashcards, currentIndex: $currentIndex, isRevealed: $isRevealed, isLoading: $isLoading, isSessionComplete: $isSessionComplete, answeredCorrectly: $answeredCorrectly, error: $error)';
}


}

/// @nodoc
abstract mixin class $FlashcardStudyStateCopyWith<$Res>  {
  factory $FlashcardStudyStateCopyWith(FlashcardStudyState value, $Res Function(FlashcardStudyState) _then) = _$FlashcardStudyStateCopyWithImpl;
@useResult
$Res call({
 List<Flashcard> flashcards, int currentIndex, bool isRevealed, bool isLoading, bool isSessionComplete, List<bool> answeredCorrectly, String? error
});




}
/// @nodoc
class _$FlashcardStudyStateCopyWithImpl<$Res>
    implements $FlashcardStudyStateCopyWith<$Res> {
  _$FlashcardStudyStateCopyWithImpl(this._self, this._then);

  final FlashcardStudyState _self;
  final $Res Function(FlashcardStudyState) _then;

/// Create a copy of FlashcardStudyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flashcards = null,Object? currentIndex = null,Object? isRevealed = null,Object? isLoading = null,Object? isSessionComplete = null,Object? answeredCorrectly = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
flashcards: null == flashcards ? _self.flashcards : flashcards // ignore: cast_nullable_to_non_nullable
as List<Flashcard>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isRevealed: null == isRevealed ? _self.isRevealed : isRevealed // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSessionComplete: null == isSessionComplete ? _self.isSessionComplete : isSessionComplete // ignore: cast_nullable_to_non_nullable
as bool,answeredCorrectly: null == answeredCorrectly ? _self.answeredCorrectly : answeredCorrectly // ignore: cast_nullable_to_non_nullable
as List<bool>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _FlashcardStudyState extends FlashcardStudyState {
  const _FlashcardStudyState({final  List<Flashcard> flashcards = const [], this.currentIndex = 0, this.isRevealed = false, this.isLoading = false, this.isSessionComplete = false, final  List<bool> answeredCorrectly = const [], this.error}): _flashcards = flashcards,_answeredCorrectly = answeredCorrectly,super._();
  

 final  List<Flashcard> _flashcards;
@override@JsonKey() List<Flashcard> get flashcards {
  if (_flashcards is EqualUnmodifiableListView) return _flashcards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flashcards);
}

@override@JsonKey() final  int currentIndex;
@override@JsonKey() final  bool isRevealed;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSessionComplete;
 final  List<bool> _answeredCorrectly;
@override@JsonKey() List<bool> get answeredCorrectly {
  if (_answeredCorrectly is EqualUnmodifiableListView) return _answeredCorrectly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answeredCorrectly);
}

// Nowe pole
@override final  String? error;

/// Create a copy of FlashcardStudyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlashcardStudyStateCopyWith<_FlashcardStudyState> get copyWith => __$FlashcardStudyStateCopyWithImpl<_FlashcardStudyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlashcardStudyState&&const DeepCollectionEquality().equals(other._flashcards, _flashcards)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.isRevealed, isRevealed) || other.isRevealed == isRevealed)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSessionComplete, isSessionComplete) || other.isSessionComplete == isSessionComplete)&&const DeepCollectionEquality().equals(other._answeredCorrectly, _answeredCorrectly)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_flashcards),currentIndex,isRevealed,isLoading,isSessionComplete,const DeepCollectionEquality().hash(_answeredCorrectly),error);

@override
String toString() {
  return 'FlashcardStudyState(flashcards: $flashcards, currentIndex: $currentIndex, isRevealed: $isRevealed, isLoading: $isLoading, isSessionComplete: $isSessionComplete, answeredCorrectly: $answeredCorrectly, error: $error)';
}


}

/// @nodoc
abstract mixin class _$FlashcardStudyStateCopyWith<$Res> implements $FlashcardStudyStateCopyWith<$Res> {
  factory _$FlashcardStudyStateCopyWith(_FlashcardStudyState value, $Res Function(_FlashcardStudyState) _then) = __$FlashcardStudyStateCopyWithImpl;
@override @useResult
$Res call({
 List<Flashcard> flashcards, int currentIndex, bool isRevealed, bool isLoading, bool isSessionComplete, List<bool> answeredCorrectly, String? error
});




}
/// @nodoc
class __$FlashcardStudyStateCopyWithImpl<$Res>
    implements _$FlashcardStudyStateCopyWith<$Res> {
  __$FlashcardStudyStateCopyWithImpl(this._self, this._then);

  final _FlashcardStudyState _self;
  final $Res Function(_FlashcardStudyState) _then;

/// Create a copy of FlashcardStudyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flashcards = null,Object? currentIndex = null,Object? isRevealed = null,Object? isLoading = null,Object? isSessionComplete = null,Object? answeredCorrectly = null,Object? error = freezed,}) {
  return _then(_FlashcardStudyState(
flashcards: null == flashcards ? _self._flashcards : flashcards // ignore: cast_nullable_to_non_nullable
as List<Flashcard>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,isRevealed: null == isRevealed ? _self.isRevealed : isRevealed // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSessionComplete: null == isSessionComplete ? _self.isSessionComplete : isSessionComplete // ignore: cast_nullable_to_non_nullable
as bool,answeredCorrectly: null == answeredCorrectly ? _self._answeredCorrectly : answeredCorrectly // ignore: cast_nullable_to_non_nullable
as List<bool>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
