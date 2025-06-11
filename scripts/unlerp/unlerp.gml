/// @func unlerp(from,to,value)
/// @desc Returns the interpolation amount such that lerp(from, to, amount) equals the given value.
/// @arg {Real} from        The first value.
/// @arg {Real} to          The second value.
/// @arg {Real} value       The interpolated value.
/// @returns {Real}
function unlerp(_from, _to, _value) {
    if (_from == _to) {
        throw "unlerp() range has zero width.";
    }
    return (_value - _from) / (_to - _from);
}
