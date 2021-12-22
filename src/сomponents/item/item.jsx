import "./item.css";

const Item = function (props) {

    const {id, name, data1, data2, data3, data4, data5} = props.item;
    
    return (
        <>
            <div className="item" data-id={id}>
                <div className="item-name">{name}</div>
                <div className="item-data">{data1}</div>
                <div className="item-data">{data2}</div>
                <div className="item-data">{data4}</div>
                <div className="item-data">{data3}</div>
                <div className="item-data">{data5}</div>
            </div>
        </>
    );
}

export default Item;