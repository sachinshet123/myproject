export function circleArea(radius) {
    return Math.PI * radius * radius;
}

export function rectangleArea(length, width) {
    return length * width;
}

export default function squareArea(side) {
    return side * side;
}

export function goodMorning() {
    window.alert('Hello Good Morning');
}

export const myName = 'Gopal Krishna Das';

export const getTermOptions = () => {
    return [{name : 'Narendra Modi', age : '77'}, {name : 'Bhaskar', age : '72'}, {name : 'Gopal', age : '72'}];
}

export const calculateMonthlyPayment = (principal, years, rate) => {
    return (principal * rate * years) / 100;
}