import { Component } from "react";
import Item from "../item/item";

import "./list-items.css";

class ListItems extends Component {

    state = {
        data: []
    }
    
    componentDidMount() {
        
        window.AddItem = (id, name, data1, data2, data3, data4, data5) => 
        {
            const newItem = {id, name, data1, data2, data3, data4, data5};

            this.setState(({data}) => {
                const newData = [...data, newItem];
                return {
                    data: newData
                }
            });
        }
    }

    render() {
        const {data} = this.state;

        const resultRender = data.map((item) => {
            return <Item key={item.id} item={item} />
        })

        return <div id="list-items">{resultRender}</div>
    }
}

export default ListItems;