import React from 'react'
import './Birdie.css'
import { ReactComponent as BirdieAvatar } from '../../assets/birdie_avatar.svg'
import { ReactComponent as BirdieOutline } from '../../assets/birdie_outline.svg'

function Birdie() {
  return (
    <div className='container'>
        <BirdieAvatar />
        <div className='birdie_title'>
            <div className='title_container'>
               
                <BirdieOutline className='birdie_outline'/>
                <h1 className='birdie'>Birdie</h1>
                
                
            </div>
            <p className='subtitle'><u>Our</u> decentralised chat app.</p>
        </div>
       
    </div>
  )
}

export default Birdie