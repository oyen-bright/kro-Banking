// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loading_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoadingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? message,
            (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)
        loading,
    required TResult Function() loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
    TResult? Function()? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
    TResult Function()? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadingEventCopyWith<$Res> {
  factory $LoadingEventCopyWith(
          LoadingEvent value, $Res Function(LoadingEvent) then) =
      _$LoadingEventCopyWithImpl<$Res, LoadingEvent>;
}

/// @nodoc
class _$LoadingEventCopyWithImpl<$Res, $Val extends LoadingEvent>
    implements $LoadingEventCopyWith<$Res> {
  _$LoadingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? message,
      (String, void Function(), int?)? action1,
      (String, void Function(), int?)? action2});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$LoadingEventCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? action1 = freezed,
    Object? action2 = freezed,
  }) {
    return _then(_$LoadingImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      action1: freezed == action1
          ? _value.action1
          : action1 // ignore: cast_nullable_to_non_nullable
              as (String, void Function(), int?)?,
      action2: freezed == action2
          ? _value.action2
          : action2 // ignore: cast_nullable_to_non_nullable
              as (String, void Function(), int?)?,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({this.message, this.action1, this.action2});

  @override
  final String? message;
  @override
  final (String, void Function(), int?)? action1;
  @override
  final (String, void Function(), int?)? action2;

  @override
  String toString() {
    return 'LoadingEvent.loading(message: $message, action1: $action1, action2: $action2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.action1, action1) || other.action1 == action1) &&
            (identical(other.action2, action2) || other.action2 == action2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, action1, action2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? message,
            (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)
        loading,
    required TResult Function() loaded,
  }) {
    return loading(message, action1, action2);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
    TResult? Function()? loaded,
  }) {
    return loading?.call(message, action1, action2);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
    TResult Function()? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message, action1, action2);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements LoadingEvent {
  const factory _Loading(
      {final String? message,
      final (String, void Function(), int?)? action1,
      final (String, void Function(), int?)? action2}) = _$LoadingImpl;

  String? get message;
  (String, void Function(), int?)? get action1;
  (String, void Function(), int?)? get action2;
  @JsonKey(ignore: true)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$LoadingEventCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl();

  @override
  String toString() {
    return 'LoadingEvent.loaded()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String? message,
            (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)
        loading,
    required TResult Function() loaded,
  }) {
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
    TResult? Function()? loaded,
  }) {
    return loaded?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
    TResult Function()? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements LoadingEvent {
  const factory _Loaded() = _$LoadedImpl;
}

/// @nodoc
mixin _$LoadingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            String? message,
            (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)
        loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_IsLoading value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_IsLoading value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_IsLoading value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadingStateCopyWith<$Res> {
  factory $LoadingStateCopyWith(
          LoadingState value, $Res Function(LoadingState) then) =
      _$LoadingStateCopyWithImpl<$Res, LoadingState>;
}

/// @nodoc
class _$LoadingStateCopyWithImpl<$Res, $Val extends LoadingState>
    implements $LoadingStateCopyWith<$Res> {
  _$LoadingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'LoadingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            String? message,
            (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)
        loading,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_IsLoading value) loading,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_IsLoading value)? loading,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_IsLoading value)? loading,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements LoadingState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$IsLoadingImplCopyWith<$Res> {
  factory _$$IsLoadingImplCopyWith(
          _$IsLoadingImpl value, $Res Function(_$IsLoadingImpl) then) =
      __$$IsLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? message,
      (String, void Function(), int?)? action1,
      (String, void Function(), int?)? action2});
}

/// @nodoc
class __$$IsLoadingImplCopyWithImpl<$Res>
    extends _$LoadingStateCopyWithImpl<$Res, _$IsLoadingImpl>
    implements _$$IsLoadingImplCopyWith<$Res> {
  __$$IsLoadingImplCopyWithImpl(
      _$IsLoadingImpl _value, $Res Function(_$IsLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? action1 = freezed,
    Object? action2 = freezed,
  }) {
    return _then(_$IsLoadingImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      action1: freezed == action1
          ? _value.action1
          : action1 // ignore: cast_nullable_to_non_nullable
              as (String, void Function(), int?)?,
      action2: freezed == action2
          ? _value.action2
          : action2 // ignore: cast_nullable_to_non_nullable
              as (String, void Function(), int?)?,
    ));
  }
}

/// @nodoc

class _$IsLoadingImpl implements _IsLoading {
  const _$IsLoadingImpl({this.message, this.action1, this.action2});

  @override
  final String? message;
  @override
  final (String, void Function(), int?)? action1;
  @override
  final (String, void Function(), int?)? action2;

  @override
  String toString() {
    return 'LoadingState.loading(message: $message, action1: $action1, action2: $action2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IsLoadingImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.action1, action1) || other.action1 == action1) &&
            (identical(other.action2, action2) || other.action2 == action2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, action1, action2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IsLoadingImplCopyWith<_$IsLoadingImpl> get copyWith =>
      __$$IsLoadingImplCopyWithImpl<_$IsLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            String? message,
            (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)
        loading,
  }) {
    return loading(message, action1, action2);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
  }) {
    return loading?.call(message, action1, action2);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message, (String, void Function(), int?)? action1,
            (String, void Function(), int?)? action2)?
        loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message, action1, action2);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_IsLoading value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_IsLoading value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_IsLoading value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _IsLoading implements LoadingState {
  const factory _IsLoading(
      {final String? message,
      final (String, void Function(), int?)? action1,
      final (String, void Function(), int?)? action2}) = _$IsLoadingImpl;

  String? get message;
  (String, void Function(), int?)? get action1;
  (String, void Function(), int?)? get action2;
  @JsonKey(ignore: true)
  _$$IsLoadingImplCopyWith<_$IsLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
