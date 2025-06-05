#include <functional>

template <typename T>
concept Hashable = requires(T a) {
  { std::hash<T>{}(a) } -> std::convertible_to<std::size_t>;
};

template <Hashable T>
auto hash(T const &v) -> decltype(std::hash<T>()(v)){
  return std::hash<int>()(v);
}
